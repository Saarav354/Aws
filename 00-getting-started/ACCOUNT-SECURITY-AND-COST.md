# Step 0: Set Up a Safe, Low-Cost AWS Account

> **Do this once, before Project 1.** It takes about 30–45 minutes.
> Everything here is done **by you** in your browser. I (your mentor) cannot log in to your AWS account, and you should **never** paste passwords, MFA codes or access keys into a chat, a GitHub repo, or anywhere else.

*Facts in this guide were checked against AWS's official pages in November 2026. AWS changes its console and pricing often, so if a screen looks different, the idea is still the same. Look for the closest matching button.*

---

## 0.1 Three words you need first

| Term | Simple meaning | Analogy |
|---|---|---|
| **Cloud computing** | Renting computing resources (storage, servers, databases, networks) over the internet and paying only for what you use, instead of buying hardware. | Like using electricity from the power grid instead of building your own power plant. You plug in, use it, and pay the bill. |
| **AWS (Amazon Web Services)** | Amazon's cloud platform. It offers 200+ services (storage, virtual machines, databases, AI…) running in Amazon's data centers around the world. | A giant hardware store + utility company: you can rent any building block you need, by the hour or by the gigabyte. |
| **AWS Management Console** | The website (`console.aws.amazon.com`) where you click buttons to create and manage AWS resources. | The control panel or dashboard of your rented infrastructure. |

Other terms you'll see on this page:

- **Region**: a geographic area where AWS has data centers, e.g. `us-east-1` (N. Virginia) or `ap-south-1` (Mumbai). Your resources live in the Region you pick. *Analogy: choosing which city's warehouse stores your goods.*
- **Availability Zone (AZ)**: one or more separate data centers inside a Region. A Region has at least 3 AZs, so one building can fail without taking everything down.
- **Global service**: some services (IAM, CloudFront, Billing) are not tied to one Region. The console shows "Global" in the top-right for those.
- **Root user**: the email address and password you sign up with. It has **unlimited power** over the account, including closing it and changing billing. *Analogy: the master key of a building.* You lock it in a safe and only take it out for rare owner-level tasks.
- **IAM user**: a separate login you create inside your account for daily work. *Analogy: an employee badge that only opens the doors you choose.*
- **MFA (Multi-Factor Authentication)**: a second proof of identity (a 6-digit code from an authenticator app, or a passkey/security key) on top of your password. Even if someone steals your password, they still can't log in.

---

## 0.2 How AWS charges you (read this before clicking anything)

### The AWS Free Tier in 2026 is different from old tutorials

Many YouTube videos say "the Free Tier gives you 12 months of free EC2". **That is the old model.** For accounts created after July 15, 2025, AWS uses this model ([AWS Free Tier page](https://aws.amazon.com/free/)):

| | **Free plan** | **Paid plan** |
|---|---|---|
| Credits | $100 at sign-up + up to $100 more by completing activities (max **$200**) | Same credits available |
| How long | Up to **6 months**, or until credits run out, whichever comes first. Then the account closes automatically (you can upgrade to keep it). | No time limit |
| Can you be charged? | **No.** Usage is deducted from credits. You are not charged unless you upgrade to the Paid plan. | Yes. After credits are used up, normal pay-as-you-go billing starts. |
| Services | Limited to a selected list of services (S3, CloudFront, EC2, Lambda, API Gateway, DynamoDB, CloudWatch are all included) | All services |

There are also **"Always Free"** limits that apply every month on both plans. Examples relevant to our 3 projects:
- **CloudFront**: 1 TB of data transfer out + 10 million HTTP/HTTPS requests per month.
- **Lambda**: 1 million requests + 400,000 GB-seconds of compute per month.
- **DynamoDB**: 25 GB of storage.

**My recommendation for you:** choose the **Free plan**. You cannot accidentally receive a credit-card bill while on it, and $200 is far more than our 3 projects need.

> ⚠️ **Free plan gotcha:** enabling **AWS Organizations**, **AWS Control Tower** or **IAM Identity Center** can convert a Free-plan account to the Paid plan. We will **not** use those in this course. That's why below we create a classic IAM user instead of using IAM Identity Center (which is AWS's recommendation for companies).

> ⚠️ **"Free" does not mean "unlimited."** Every service has limits. A forgotten EC2 instance, a NAT Gateway, an unattached Elastic IP or a big data transfer can burn through credits fast. That's why every project ends with a **cleanup checklist**.

### How to estimate cost before creating something

1. Open the official **AWS Pricing Calculator**: <https://calculator.aws/>
2. Click **Create estimate** → search the service (e.g. "S3") → choose your Region → enter your expected usage.
3. It shows a monthly estimate. For Project 1 you'll see it rounds to **$0.00–$0.01/month**.

---

## 0.3 Create your AWS account (YOU do this)

1. Go to <https://aws.amazon.com/free/> → **Create a free account**.
2. AWS is rolling out a new sign-up experience (announced September 2026). Depending on what you see, you can sign up with **email**, or with **Google / GitHub / Apple**. Either is fine.
3. Use a personal email address you control long-term. Choose a **strong, unique password** (use a password manager).
4. When asked, choose the **Free plan**.
5. You may be asked for phone verification and, depending on the flow, a payment card for identity verification. On the Free plan you are not charged unless you upgrade.
6. Support plan: choose **Basic support – Free**.

**How to verify it worked:** you can sign in at <https://console.aws.amazon.com/> and you see the **Console Home** page.

**Common problems**
| Problem | Fix |
|---|---|
| Phone verification code never arrives | Try the voice-call option, check the country code, wait a few minutes, retry. |
| "Account is being activated" | Activation can take a few minutes up to 24 hours. Wait for the confirmation email. |
| Card declined (if asked) | Some debit cards don't support international transactions. Enable online/international use or try another card. |

---

## 0.4 Lock down the root user (YOU do this, ~5 minutes)

**Why:** the root user can do *anything*, including deleting everything and changing billing. If it is compromised, an attacker can launch expensive servers (crypto-mining is the classic attack).

1. Sign in as root → in the top search bar type **IAM** → open **IAM**.
2. The IAM dashboard shows **Security recommendations**. Click **Add MFA** for the root user.
3. Choose **Passkey or security key** (best) or **Authenticator app** (e.g. Google Authenticator, Microsoft Authenticator, Authy).
4. Follow the prompts (scan the QR code, enter two consecutive codes).
5. **Never create access keys for the root user.** If the dashboard shows root access keys exist, delete them.

✅ **Verify:** IAM dashboard → Security recommendations shows a green check for root MFA.

---

## 0.5 Let IAM users see billing (YOU do this as root)

By default, even an IAM administrator **cannot** see billing pages. We want to see costs from your daily login.

1. Still signed in as root, click your account name (top-right) → **Account**.
2. Scroll to **IAM user and role access to Billing information** → **Edit** → tick **Activate IAM Access** → **Update**.

---

## 0.6 Create your daily-use IAM user (YOU do this)

**What is IAM?** **IAM (Identity and Access Management)** is the AWS service that answers two questions for every request:
1. **Who are you?** (*authentication*: proving identity with a password/MFA/keys)
2. **What are you allowed to do?** (*authorization*: checking permissions)

IAM is free.

| IAM concept | Meaning | Analogy |
|---|---|---|
| **User** | A permanent identity for one person or app, with long-term credentials (password and/or access keys). | An employee with their own badge. |
| **Group** | A collection of users that share the same permissions. | A department ("Developers") whose badges all open the same doors. |
| **Role** | An identity with permissions but **no** password or permanent keys. Someone or something (an EC2 server, a Lambda function, an AWS service) *temporarily assumes* it and gets short-lived credentials. | A visitor pass handed out at reception that expires in an hour. |
| **Policy** | A JSON document that lists what is **Allowed** or **Denied** (`Action`, `Resource`, optional `Condition`). Attached to users, groups, roles, or resources like S3 buckets. | The written rule-book saying which doors a badge opens. |
| **Least privilege** | Give each identity only the permissions it actually needs. | A cleaner gets the key to the corridors, not the safe. |

Steps:

1. IAM → **Users** → **Create user**.
2. **User name**: `admin-<yourname>` (e.g. `admin-kiran`). Use any name you like.
3. Tick **Provide user access to the AWS Management Console**. If asked, pick **I want to create an IAM user**.
4. **Custom password** → strong password. Untick "must create a new password" (optional).
5. **Next** → **Permissions options** → **Attach policies directly** → search and tick **AdministratorAccess**.
   - *Why admin and not least privilege?* For a personal learning account, you'll be creating many kinds of resources. In companies you would get narrow permissions. In Project 3 we will write a least-privilege policy ourselves so you learn how.
6. **Next** → **Create user**. On the final page, copy the **Console sign-in URL** (looks like `https://123456789012.signin.aws.amazon.com/console`) and bookmark it. **Do not download or create access keys.**
7. Open the user → **Security credentials** tab → **Assign MFA device** → set up MFA for this user too.
8. (Optional, nice) IAM dashboard → **AWS Account** → **Account Alias** → **Create** → e.g. `kiran-learning`. Your sign-in URL becomes `https://kiran-learning.signin.aws.amazon.com/console`.
9. **Sign out of root. From now on, always sign in with this IAM user.**

✅ **Verify:** sign in via the bookmarked URL with the IAM user name + password + MFA. The top-right shows `admin-<yourname> @ <account-id-or-alias>`.

---

## 0.7 Set up billing alarms with AWS Budgets (YOU do this, ~10 minutes)

**What is AWS Budgets?** A free service that watches your spending and **emails you** when actual or forecast cost crosses a threshold. *Analogy: a low-balance SMS from your bank.*

> Important: a budget **alerts** you. It does **not** automatically stop resources. (Newer accounts may also see a **Spend limit** feature from the new sign-up experience that can *pause* a project at a cap. If you have it, set a small limit such as $20. If you don't see it, Budgets alerts are enough.)

**Budget 1: Zero-spend budget (alerts on the very first cent)**
1. Search bar → **Billing and Cost Management** → left menu **Budgets** → **Create budget**.
2. **Use a template (simplified)** → **Zero spend budget**.
3. Name: `zero-spend-alert`. Email: your email. → **Create budget**.

**Budget 2: Monthly cost budget**
1. **Create budget** → **Use a template** → **Monthly cost budget**.
2. Name: `monthly-5-usd`. Budgeted amount: **5.00** USD. Email: your email.
3. It creates alerts at 85% actual, 100% actual, and 100% forecasted. → **Create budget**.

> 💡 **Credits note:** on the Free plan, usage is paid by credits, so your *net* cost may stay at $0 even while you consume credits. If you choose the **Customize (advanced)** option, AWS lets you decide whether credits are included. Excluding credits makes the budget warn you about real usage. Also check these two pages regularly:
> - **Billing and Cost Management → Credits**: how much of your $100–$200 is left.
> - **Billing and Cost Management → Free Tier**: how close you are to each service's free limit.

✅ **Verify:** Budgets list shows both budgets with status OK. Check your email inbox for any AWS confirmation emails.

---

## 0.8 Pick ONE Region and stick to it

The Region selector is at the top-right of the console. Resources in one Region are **invisible** when you look at another Region. This is the #1 cause of "my bucket/instance disappeared!" panic, and of forgotten resources that keep costing money.

- Pick the Region closest to you, e.g. **Asia Pacific (Mumbai) `ap-south-1`** if you're in India, or **US East (N. Virginia) `us-east-1`** (AWS's largest and usually cheapest Region).
- Use the **same Region for all 3 projects**. Write it down: `My Region = ____________`.

---

## 0.9 Install your local tools (Windows)

| Tool | Needed for | Install |
|---|---|---|
| **VS Code** | Editing website / code files | <https://code.visualstudio.com/> |
| **Git for Windows** (includes **Git Bash**) | Version control + pushing to GitHub | <https://git-scm.com/download/win> |
| A modern browser (Chrome/Edge/Firefox) | AWS Console + testing | Already installed |
| **PowerShell** | Testing with `curl.exe` | Already included in Windows 10/11 |
| *(Project 2)* OpenSSH client | Connecting to EC2 | Built into Windows 10/11 (`ssh` command) |
| *(Project 3)* **Postman** | Testing the API | <https://www.postman.com/downloads/> |
| *(Optional, later)* **AWS CLI v2** | Automating deployments from the terminal | <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html> |

Verify in **PowerShell**:
```powershell
git --version        # expected: git version 2.x.x.windows.x
code --version       # expected: a version number (if VS Code is on PATH)
curl.exe --version   # expected: curl 8.x ... (Windows ships curl.exe)
```

> Why `curl.exe` and not `curl`? In older Windows PowerShell, `curl` is an alias for `Invoke-WebRequest`, which behaves differently. Typing `curl.exe` always runs the real curl.

---

## ✅ Step 0 checklist

- [ ] AWS account created on the **Free plan**
- [ ] Root user has MFA, no root access keys
- [ ] IAM billing access activated
- [ ] IAM admin user created, MFA enabled, sign-in URL bookmarked
- [ ] Signed out of root; working as the IAM user
- [ ] `zero-spend-alert` and `monthly-5-usd` budgets created
- [ ] One Region chosen and written down
- [ ] VS Code + Git installed

When all boxes are ticked → go to [Project 1](../project-1-s3-cloudfront/README.md).
