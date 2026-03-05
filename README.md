# aws-serverless-minecraft-infra

**Event-driven, cost-optimized serverless infrastructure for on-demand compute provisioning using AWS Lambda, EC2, and Terraform.**

---

### 🏗️ Architecture Overview

![AWS Architecture Diagram]()

This project implements a **decoupled, event-driven architecture** to manage game server infrastructure. By separating the **Control Plane** (AWS Lambda/API Gateway) from the **Data Plane** (EC2), the architecture achieves near-zero cost during idle states while ensuring high availability for user-initiated start/stop commands.

---

### 🛡️ Engineering & Security Posture

This architecture was designed with a "Defense in Depth" strategy:

* **Serverless Control Plane:** Uses AWS Lambda to handle Discord webhooks. This eliminates the need for an "always-on" server to manage game state, reducing the operational attack surface and compute costs.
* **Zero-SSH Management:** Administrative access is enforced via **AWS Systems Manager (SSM) Session Manager**. This eliminates the need for inbound Port 22 (SSH) exposure, effectively mitigating brute-force and credential-based attack vectors.
* **Principle of Least Privilege (IAM):** The Lambda execution role follows strict IAM policies, granting only the `ec2:StartInstances` and `ec2:StopInstances` permissions.
* **Network Segmentation:** The game server is isolated within a Private Subnet. Connectivity is strictly governed by Security Groups configured with stateful ingress/egress rules, allowing only necessary traffic on Port 25565.
* **Infrastructure as Code (IaC):** 100% of the stack is provisioned via **Terraform**. This ensures environment parity, version control of infrastructure, and rapid reproducibility.

---

### 🛠️ Technology Stack

| Category | Component | Purpose |
| :--- | :--- | :--- |
| **Provisioning** | Terraform | Infrastructure as Code |
| **Control Plane** | API Gateway & Lambda | Event-driven webhook handling |
| **Compute** | Amazon EC2 | Minecraft Game Server |
| **Identity** | AWS IAM | Permission management |
| **Admin Access** | AWS SSM Session Manager | Secure, port-less remote access |

---

### 🚀 Getting Started

#### Prerequisites
* AWS CLI installed and configured.
* Terraform v1.x installed.
* Discord Bot Token (for webhook authentication).

#### Deployment
1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/your-username/aws-serverless-minecraft-infra.git](https://github.com/your-username/aws-serverless-minecraft-infra.git)
    cd aws-serverless-minecraft-infra
    ```
2.  **Initialize Terraform:**
    ```bash
    terraform init
    ```
3.  **Review Plan:**
    ```bash
    terraform plan
    ```
4.  **Deploy:**
    ```bash
    terraform apply
    ```

---

### 💡 Future Scope
* **Cost Optimization:** Implementing an automated "Shutdown on Empty" logic using CloudWatch metrics to terminate instances with zero active players.
* **DNS Integration:** Mapping the EC2 Elastic IP to a Route53 DNS record for cleaner server connectivity.
* **Backup Automation:** Using AWS Backup or custom Lambda snapshots to automate state preservation.

---

### 📝 Author's Note
This repository serves as a practical demonstration of cloud-native design patterns. It illustrates how to leverage managed AWS services to build secure, scalable, and cost-effective infrastructure.
