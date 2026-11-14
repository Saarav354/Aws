<#
.SYNOPSIS
    Deploys the Project 1 static website to S3 and invalidates the CloudFront cache.

.DESCRIPTION
    OPTIONAL. You can do the same thing by clicking in the AWS Console.
    Requirements:
      - AWS CLI v2 installed (aws --version)
      - Signed in WITHOUT long-lived keys via `aws login` (AWS CLI 2.32.0+)
    This script NEVER contains credentials. Never put access keys in scripts or Git.

.EXAMPLE
    .\project-1-s3-cloudfront\scripts\deploy.ps1 -BucketName "yourname-cloud-journey-site-2026" -DistributionId "E2ABCDEF12345"
#>

param(
    [Parameter(Mandatory = $true)] [string] $BucketName,
    [Parameter(Mandatory = $true)] [string] $DistributionId,
    # Paths to invalidate. "/*" counts as ONE path (first 1,000 paths per month are free).
    [string] $InvalidationPath = "/*"
)

$ErrorActionPreference = "Stop"

# Folder that holds index.html, error.html and assets/ (relative to this script).
$WebsiteDir = Join-Path $PSScriptRoot "..\website"

Write-Host "1/3  Checking who you are signed in as..." -ForegroundColor Cyan
aws sts get-caller-identity
if ($LASTEXITCODE -ne 0) { throw "Not signed in. Run 'aws login' first." }

Write-Host "2/3  Syncing $WebsiteDir  ->  s3://$BucketName ..." -ForegroundColor Cyan
# sync = upload only new/changed files; --delete = remove files from S3 that you deleted locally.
aws s3 sync $WebsiteDir "s3://$BucketName" --delete
if ($LASTEXITCODE -ne 0) { throw "S3 sync failed." }

Write-Host "3/3  Creating CloudFront invalidation for '$InvalidationPath' ..." -ForegroundColor Cyan
aws cloudfront create-invalidation --distribution-id $DistributionId --paths $InvalidationPath
if ($LASTEXITCODE -ne 0) { throw "Invalidation failed." }

Write-Host "Done. Wait ~1 minute, then refresh your CloudFront URL with Ctrl+F5." -ForegroundColor Green
