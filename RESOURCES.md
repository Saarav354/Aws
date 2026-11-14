# AWS Learning Resources: In the Order to Follow Them

Each link below was checked in November 2026. I picked a few resources per phase instead of dozens. **Don't binge them all first.** Watch the one for the project you're on, then build.

> Tip: AWS's console changes often. If a video's screens look different from yours, trust the **concept** in the video and the **click-path** in our project guide. Also, older videos teach the old "12 months free" Free Tier. That model no longer applies to new accounts (see Step 0).

---

## Phase 0: Foundations (before / during Project 1)

| # | Resource | Channel / Source | What you'll learn | Why I recommend it |
|---|---|---|---|---|
| 1 | [AWS Cloud Practitioner Essentials](https://skillbuilder.aws/learn/94T2BEN85A/aws-cloud-practitioner-essentials/8D79F3AVR7) (free course) | **AWS Skill Builder (official)** | Cloud concepts, global infrastructure, core services, security, pricing & billing | Official, free, short modules, beginner-pitched. The best "what is cloud/AWS" foundation. |
| 2 | [AWS Certified Cloud Practitioner Certification Course 2026 (CLF-C02)](https://www.youtube.com/watch?v=7HKot-brXFE) | **freeCodeCamp.org** (Andrew Brown) | Every core AWS service with hands-on follow-alongs | Updated for 2026; long (~14h), so use it as a **reference**: watch the S3, CloudFront, IAM sections now; EC2 for Project 2; Lambda for Project 3. |
| 3 | [AWS Cloud Practitioner (CLF-C02) shorter course](https://www.youtube.com/watch?v=NhDYbskXRgc) | **freeCodeCamp.org** | Cloud concepts, account setup, IAM basics, core services in ~3h with chapters | A lighter alternative to #2 if 14 hours feels like too much. |
| 4 | [AWS Training & free digital courses hub](https://aws.amazon.com/training/) | **AWS (official)** | 600+ free courses, learning plans | Where to find more official free learning after these projects. |

## Phase 1: Project 1 (S3 + CloudFront)

| # | Resource | Channel / Source | What you'll learn | Why I recommend it |
|---|---|---|---|---|
| 5 | [Get started with a CloudFront standard distribution](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/GettingStarted.SimpleDistribution.html) | **AWS Docs (official)** | The current S3 + CloudFront + OAC wizard, step by step | It matches today's console. Our guide is based on it. |
| 6 | [Restrict access to an Amazon S3 origin (OAC)](https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/private-content-restricting-access-to-s3.html) | **AWS Docs (official)** | How OAC works, the bucket policy, edge cases (KMS, website endpoints) | The authoritative explanation of the security core of Project 1. |
| 7 | [How to Host a Static Website on AWS S3 and CloudFront (with OAC)](https://www.youtube.com/watch?v=2xxcvJJ8eOY) | YouTube tutorial | Visual walkthrough of a private bucket + OAC setup | Watching someone click through it helps before you do it yourself. Prefer OAC-based videos. Skip any that make the bucket public. |
| 8 | [Amazon CloudFront Pricing](https://aws.amazon.com/cloudfront/pricing/) | **AWS (official)** | Free limits, pay-as-you-go vs flat-rate plans | Know what's free before you click. |

## Phase 2: Project 2 (EC2 + Linux + Nginx)

| # | Resource | Channel / Source | What you'll learn | Why I recommend it |
|---|---|---|---|---|
| 9 | freeCodeCamp course (#2 above), **EC2 / VPC / Security Group sections** | **freeCodeCamp.org** | Instances, AMIs, instance types, security groups, key pairs | You already have it bookmarked; its follow-alongs map to Project 2. |
| 10 | [Get started with Amazon EC2 (Linux)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html) | **AWS Docs (official)** | Launching, connecting to and cleaning up an instance | The official current click-path. |

*I'll add verified Linux and EC2 videos when we start Project 2.*

## Phase 3: Project 3 (Lambda + API Gateway)

| # | Resource | Channel / Source | What you'll learn | Why I recommend it |
|---|---|---|---|---|
| 11 | [Building REST APIs on AWS (playlist)](https://www.youtube.com/playlist?list=PL9nWRykSBSFjHhg11falLLKxVExFnt1_c) | **Be A Better Dev** | API Gateway + Lambda, step by step | Clear, practical, developer-focused explanations. |
| 12 | [AWS Lambda Guides (playlist)](https://www.youtube.com/playlist?list=PL9nWRykSBSFjodfc8l8M8yN0ieP94QeEL) | **Be A Better Dev** | Lambda basics, triggers, integrations with other services | Covers the event-driven "trigger" concept we'll use. |
| 13 | [AWS API Gateway Tutorials (playlist)](https://www.youtube.com/playlist?list=PL9nWRykSBSFhOPUJaA4uaKfroosVbUZX9) | **Be A Better Dev** | Auth (Cognito, authorizers), throttling, API types | Useful for the "authentication & authorization" part of Project 3. |
| 14 | [AWS DynamoDB Tutorial For Beginners](https://www.youtube.com/watch?v=2k2GINpO308) | **Be A Better Dev** | Tables, keys, queries | For the DynamoDB upgrade at the end of Project 3. |

## Phase 4: Architecture & interviews (after the 3 projects)

| # | Resource | Source | Why |
|---|---|---|---|
| 15 | [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/) | AWS (official) | The 6 pillars interviewers expect you to know (security, reliability, cost, performance, operations, sustainability). |
| 16 | [AWS Architecture Center](https://aws.amazon.com/architecture/) | AWS (official) | Real reference architectures with diagrams. |
| 17 | [AWS Certified Cloud Practitioner exam page](https://aws.amazon.com/certification/certified-cloud-practitioner/) | AWS (official) | A good first certification goal once you finish the projects. |

*Channels you mentioned (TechWorld with Nana, Stephane Maarek, Adrian Cantrill, Digital Cloud Training) are all good. Stephane Maarek's and Adrian Cantrill's full courses are mostly paid, outside YouTube. I'll only add a specific video from them when I've verified it fits the project we're on.*
