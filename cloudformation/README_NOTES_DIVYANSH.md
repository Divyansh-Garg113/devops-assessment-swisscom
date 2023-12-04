# Solution for cloudformation/ assessment

# Resources added/modified in `stack_template` cft template to obtain the desired solution
1. S3Bucket
    - Source s3 bucket
2. S3LoggingBucket
    - S3 bucket used by source bucket as access logs destination
3. S3BucketPolicy
    - A simple bucket policy attached to the S3Bucket resource
4. S3LoggingBucketPolicy
    - Bucket policy attached to the S3LoggingBucket resource for access log delivery of S3Bucket resource on s3:PutObject event
5. S3LoggingBucketDeleteObjectPolicy
    - Bucket policy attached to the S3LoggingBucket resource for access log delivery to itself in case an object is deleted from the bucket (s3:DeleteObject event)


# cfn-nag warnings and applied fix in `stack_template` cft template

1. **WARNING** - Resource: ["S3Bucket"] : S3 bucket should likely have a bucket policy
**FIX** - Added the Resource `S3BucketPolicy` and attached it the bucket. The bucket policy allows s3:PutObject event for the bucket.

2. **WARNING** - Resource: ["S3Bucket"] S3 Bucket should have encryption option set
**FIX** - Added `BucketEncryption` property to configure default server side encryption using AES256 algorithm

3. **WARNING** - Resource: ["S3Bucket"] S3 Bucket should have access logging configured
**FIX** - Added `LoggingConfiguration` property with destination bucket as `S3LoggingBucket` resource. Also attached a bucket policy `S3LoggingBucketPolicy` to the destination bucket `S3LoggingBucket` to allow access logs to be written inside `logs/`folder of destination bucket.

4. **WARNING** - Resource: ["S3LoggingBucket"] S3 Bucket should have encryption option set
**FIX** - Added `BucketEncryption` property to configure default server side encryption using AES256 algorithm

5. **WARNING** - Resource: ["S3LoggingBucket"] S3 Bucket should have access logging configured
**FIX** - Added `LoggingConfiguration` property with destination bucket same as the source bucket in this case (`S3LoggingBucket`). Also attached a bucket policy `S3LoggingBucketDeleteObjectPolicy` to the bucket which will allow writing logs to `deleted-object-logs/`folder whenever an object is deleted from this bucket.


# The CloudFormation template has been tested locally on MacOS platform and it runs as expected. In case of any doubt, please reach out to me at divyansh112@hotmail.com

I hope you liked my solution. I Look forward for a nice discussion.