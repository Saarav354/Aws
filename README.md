# My AWS Learning Journey: 3 Hands-On Projects from Absolute Zero

A practical AWS training program: learn cloud by **building**, **testing**, **breaking** and **explaining** real projects.

| # | Project | AWS services | Status |
|---|---|---|---|
| 0 | [Account, security & cost setup](00-getting-started/ACCOUNT-SECURITY-AND-COST.md) | IAM, MFA, AWS Budgets, Billing | 🟡 Do this first |
| 1 | [Static website on S3 + CloudFront](project-1-s3-cloudfront/README.md) | S3, CloudFront, OAC, IAM | 🟡 In progress |
| 2 | Web server on EC2 | EC2, VPC, Security Groups, SSH, Linux, Nginx | ⏳ Next |
| 3 | Serverless REST API | Lambda, API Gateway, IAM roles, CloudWatch, (DynamoDB) | ⏳ Planned |

📺 **Learning resources (YouTube first, in order):** [RESOURCES.md](RESOURCES.md)

## How the three architectures fit together

```
Project 1 (static)   Browser ──HTTPS──► CloudFront ──OAC──► S3 (private files)
Project 2 (server)   Browser ──HTTP───► Public IP ──► Security Group ──► EC2 (Linux + Nginx)
Project 3 (API)      Postman ──HTTPS──► API Gateway ──► Lambda ──► (DynamoDB) ──► JSON response
```

## Repository layout

```
.
├── README.md                          ← you are here (roadmap)
├── RESOURCES.md                       ← curated videos, docs, Skill Builder
├── 00-getting-started/
│   └── ACCOUNT-SECURITY-AND-COST.md   ← Free plan, MFA, IAM user, Budgets, Region, tools
└── project-1-s3-cloudfront/
    ├── README.md                      ← full step-by-step guide + tests + interview Qs + cleanup
    ├── website/                       ← the site you deploy
    │   ├── index.html
    │   ├── error.html
    │   └── assets/ (styles.css, script.js)
    └── scripts/deploy.ps1             ← optional AWS CLI deploy (sync + invalidate)
```

## Golden rules for this journey

1. **Never** share or commit passwords, MFA codes or AWS access keys. Prefer IAM roles and short-lived credentials.
2. Know the cost **before** you create something; keep your **Budgets** alerts on.
3. Use **one Region** for everything.
4. Never open all ports to the internet; never make buckets public without a reason.
5. Finish every project with its **cleanup checklist**.
