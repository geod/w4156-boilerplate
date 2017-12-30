# import boto3
#
# print('creating dynamodb resource')
#
# dynamodb = boto3.resource(
#     'dynamodb',
#     endpoint_url='http://localhost:8000',
#     region_name='dummy_region',
#     aws_access_key_id='dummy_access_key',
#     aws_secret_access_key='dummy_secret_key',
#     verify=False)
#
# print('got resource:', dynamodb)
#
# print('adding table')
#
# result = dynamodb.create_table(
#     TableName='foo',
#     KeySchema=[
#         {
#             'AttributeName': 'from_email',
#             'KeyType': 'HASH'  # Partition key
#         },
#         {
#             'AttributeName': 'raw_id',
#             'KeyType': 'RANGE'  # Sort key
#         },
#     ],
#     AttributeDefinitions=[
#         {
#             'AttributeName': 'from_email',
#             'AttributeType': 'S'
#         },
#         {
#             'AttributeName': 'raw_id',
#             'AttributeType': 'N'
#         },
#     ],
#     ProvisionedThroughput={
#         'ReadCapacityUnits': 10,
#         'WriteCapacityUnits': 10
#     }
# )
#
# print('created table:', result)
#
# print('getting table')
#
# table = dynamodb.Table('foo')
#
# print('got table:', table)
