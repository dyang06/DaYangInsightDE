import sys

bucketName = sys.argv[1]
fileName = sys.argv[2]
bootstrapServer = sys.argv[3]
Topic = sys.argv[4]

# # Create topics
# from kafka.admin import KafkaAdminClient, NewTopic
# admin_client = KafkaAdminClient(
#     bootstrap_servers=bootstrapServer,
#     client_id='test'
# )
#
# topic_list = []
# topic_list.append(NewTopic(name=Topic, num_partitions=4, replication_factor=2))
# admin_client.create_topics(new_topics=topic_list, validate_only=False)
# print(Topic + ': topic has been created')


# read file from s3
import boto3
s3    = boto3.resource('s3')
obj   = s3.Object(bucketName,fileName)
body  = obj.get()['Body'].read().decode('utf-8')
lines = body.split('\n')
print(fileName)
# produce messages
# dd = np.array(d["signal"].strip("[]").split(","))
# produce

from kafka import KafkaProducer
producer = KafkaProducer(bootstrap_servers=bootstrapServer)
print(bootstrapServer)

nLine = 0
for line in lines:
    if line == '':
        continue
    producer.send(Topic, value=line.encode('utf-8'))
    nLine += 1
print(Topic)
print(str(nLine)+' lines produced')
