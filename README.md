# Azure Infrastructure as Code Challenge

## Overview
This repository contains a Terraform-based Azure deployment for a secure and highly available web application platform.

The goal of this solution is not to build a complex application, but to demonstrate strong infrastructure design, security practices, and Terraform structuring.

---

## Architecture Diagram

![Architecture Diagram](./diagrams/architecture.png)

*Figure: Secure multi-tier architecture with Application Gateway, VM Scale Set, and private PostgreSQL database.*

---

## Architecture Summary

The solution follows a layered architecture:

- **Ingress Layer**  
  Azure Application Gateway (v2) handles HTTPS traffic, TLS termination, and routing.

- **Compute Layer**  
  Azure Virtual Machine Scale Set (VMSS) runs a simple Nginx web application across multiple instances.

- **Data Layer**  
  Azure PostgreSQL Flexible Server is deployed in a private subnet and is not publicly accessible.

- **Security**  
  - Only Application Gateway is exposed to the internet  
  - Web tier is private and accessible only via the gateway  
  - Database tier is fully private  
  - TLS is enforced at the edge  

- **DNS**  
  Azure DNS is used to map a custom domain name to the Application Gateway public IP.

- **Certificate Management**  
  TLS certificates are stored and managed using Azure Key Vault.

---

## Design Decisions

### Why Application Gateway?
Application Gateway provides Layer 7 routing, HTTPS termination, and integration with Key Vault for certificate management. It is well-suited for web application ingress.

### Why VM Scale Set?
The assignment requires virtual machines for the compute tier. VM Scale Set provides high availability and scalability while keeping a VM-based architecture.

### Why PostgreSQL Flexible Server?
A managed database service reduces operational overhead and allows for secure private networking, which aligns with production best practices.

### Why Key Vault?
Key Vault enables secure storage and management of TLS certificates, keeping secrets separate from application and infrastructure logic.

### Network Design
The Virtual Network is divided into three subnets:
- Application Gateway subnet
- Web tier subnet
- Database subnet (delegated for PostgreSQL)

This ensures clear separation of responsibilities and controlled traffic flow.

---

## Repository Structure

```text
.
├── README.md
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
├── versions.tf
├── scripts/
│   └── cloud-init-nginx.sh
├── diagrams/
│   └── architecture.png
└── modules/
    ├── resource_group/
    ├── network/
    ├── key_vault/
    ├── compute/
    ├── application_gateway/
    ├── database/
    └── dns/
