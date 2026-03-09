import time
import boto3
from mcstatus import JavaServer

#CONFIG
CHECK_INTERVAL = 600 # 10 minutes
MAX_EMPTY_CHECKS = 3

def get_instance_id():

    """Fetch Insance ID from IMDSv2."""
    try:
        #Get token for IMDSv2
        token_url = "http://169.254.169.254/latest/api/token"
        token = requests.put(token_url, headers={"X-aws-ec2-metadata-token-ttl-seconds": "21600"}).text

        #Get instance ID using the token
        id_url = "http://169.254.169.254/latest/meta-data/instance-id"
        return requests.get(id_url, headers={"X-aws-ec2-metadata-token": token}).text
    except Exception as e:
        print(f"Error fetching instance ID: {e}")
        return None
    
# Intialization 
INSTANC_ID = get_instance_id()
ec2 = boto3.client('ec2', region_name='us-east-1') 
server = JavaServer.lookup("127.0.0.1:25565")
empty_count = 0

print(f"Monitoring Minecraft server on instance {INSTANC_ID}...")

while True:
    try:
        status = server.status()
        online_players = status.players.online
        print(f"Online players: {online_players}")

        if online_players == 0:
            empty_count += 1
        else:
            empty_count = 0 # reset count if players are online

    except Exception as e:

        empty_count += 1
    
    if empty_count >= MAX_EMPTY_CHECKS:
        print("No players detected for a while. Stopping instance...")
        try:
            ec2.stop_instances(InstanceIds=[INSTANC_ID])
            print("Instance stopped successfully.")
        except Exception as e:
            print(f"Error stopping instance: {e}")
        break
    time.sleep(CHECK_INTERVAL)