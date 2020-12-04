# GCP Prof Data Eng

## Storage and Databases

```
    (Cloud Storage) <- No -- [If Structured]
                                    |
                                   YES
                                    V
                              [If Analytics]- YES -> [If low Latency] - No -> (Big Query)
                                    |                   |
                                    NO                 YES
                                    V                   V
     [If scalability] <- YES- [if Relational]         (Cloud BigTable)  
      |         |                   |
     Yes        NO                  NO
      V         V                   V
 (Cloud       (Cloud            [if NoSQL]
 Spannner)     SQL)                 |
                                   YES
                                    V
                             (Cloud Firestore)

              [If Memstore] -> Cloud Memorystore
```

1. Cloud Storage
    - Unstructured object storage as opeque data -> immutable -> atomic
    - Regional, dual-region or multi region
    - Standard <30 days , nearline > 30 days and coldline > 365 days - performance is constant but retriving costs diff 
    - Storage event trigger
        - GCP console
        - HTTP Api
        - SDK's
        - gsutil
    * Parallel upload of composite objects
    * Integrity checking MD5 or 
    * Transcoding
    * Requestor pays
    * Life cycle rules
    + IAM for bulk access to buckets 
    + ACLs for granular access to buckets
    + signed URLs
    + signed policy documents
    + bucket names must be unique within all GCP project

2. Cloud Big table
    - Petabyte-scale NoSQl database
    - High-throughput and scalability
    - Wide column key/value data
    - Time-series, Transactional, Iot data

3. Big Query
    - Petabyte-scale analytics data warehouse
    - Fast SQL queries across large datasets
    - Foundations for BI and AI
    - Public datasets

4. Cloud Spanner 
    - Global SQL-based relational database
    - Horizontal scalability and high availability
    - Strong consistency
    - breaks CAP theorem with 99.99% SLA it chooses CP priority 

5. Cloud SQl
    - Managed MySQL, PostgresSQl instance and SQL server (Experimental)
    - Build-in backups,replicas and failover
    - Vertical scalable
        - MySQL 
            - Community edition Mysql 5.6 or 5.7
            - upto 416GB RAM and 30 TB storage
            - secure external connections with cloud SQL proxy or ssl/TLS
            - Maintenance Window
            - Automated backups
            - Instance restores
            - Point-in-time recovery
                - requires binary logging
        - Postgresql
            - Postgresql version 9.6 or 11
            - upto 416GB RAM and 30 TB storage
            - secure external connections with cloud SQL proxy or ssl/TLS
            - Maintenance Windows
            - Automated backups
            - Instance restores
            - Sql dump export/import - csv import


6. Cloud Firestore 
    - Fully managed No Sql document database
    - Large collections of small JSON documents
    - realtime database with mobile SDKs
    - Strong consistency
    - Composite index

7. Cloud Memporystore
    - Managed Redis instances version 3.2 or 4
    - memory capacity 1-300 GB
    - In-memory DB, cache, message broker
    - build-in high availability
    - Vertically scalable
    - Session Cache or Message Queue or Pub/Sub

#### Identity & access Manaagement

| human |  service account |
|-------|------------------|
|Authentication with their own credential, tied to the lifecycle of the user |Created for a specific non-human task requiring granular authorization  |
|Should not be used for non-human operations| Identity can be assumed by an application/workload |
|Password,key,etc. could leak into source code|keys can be rotated |

#### ACLs

|Permission|Buscket|Object|
|----------|-------|------|
|Reader|List a bucket's contents and metadata|Download an object|
|Writer|List,create,overwrite and delete objects ina bucket| Cannot be applied to individual objects|
|Owner|Grants READER and Writer permission also allowed access to bucket ACLs|Grant READER access. Also grants access to object metadata and ACLs|
|Default|Predefined project-private ACL applied|Predefined project-private ACL applied|

## Open Source Project

### Hadoop 
- Hadoop common
- Hadoop Distributed File System (HDFS)
- Hadoop Yarn
- Hadoop MapReduce

### Apache Pig
- High level language 
- ETL 
- load, filters,split,group

### Apache Spark
- general purpose cluster computing framework
- works on RDD
- Spark SQL, Spark streaming, MLLib, GraphX

### Apache Kafka
- Pub/Sub to streams of records
- hight throughput and low latency
- handling >8000 billion message per day at linkedIN
- Producer,Consumer,Streams,connector

#### Pub/Sub GCP
- Atlease Once Deliver and order is not guaranteed (We can recive same message multiple time)
- Pub/sub only allow 10MB of max data to push
- A push Subscription endpoint must accept an HTTPS POST with a valid SSL certificate. It must also be configured to use an authentication header.
- Undelivered message are deleted after some retention duration
- Message published before a subscribtion is created will not be delivered to that subscription
- Subscription expire after 31 days of inactivity(That can be changed if message comes after expire day this subscription will not get the message even if we create subscription with same name)
- Message retention duration can be configured between 10 minutes and 7 days
- Acknowledge message are no longer avaliable to the subscribers
- Every message must be processed by a subscription
- Commands:
    - gcloud pubsub topics create my-topic #(Topic)
    - gcloud pubsub subscriptions create my-sub --topic my-topic #(equivalent to consumer in gcp subscription)
    - gcloud pubsub topics publish my-topic --message="hello" #(Push message equavalent to producer)
    - gcloud pubsub subscriptions pull my-sub --auto-ack #(Pull to consume message)
    - gcloud pubsub subscriptions delete my-sub
    - gcloud pubsub topics delete my-topic

#### Dataflow (Apache BEAM)
- Process batch or streaming data #imp cloud composer is Orchestration tasks 
- Fully managed, serverless tool
- Uses opensource Apache Beam SDK
- Supports expressive SQL, Java and pyhton Api's
- Real time or bacth processing
```


Source's        ------> Pipeline (Cloud Dataflow)---> Sink's

(Cloud  (BigQuery) (Cloud                               (Cloud   (BigQuery) (Bigtable) (Cloud Machine Learning) 
Pub/Sub)            storage)                            Storage)



Cloud data flow using PCollection
|-----------------------------------------------------------------| 
|Bounded          |-----------|                                   |
|(Batch) -------->|           |                                   |   
|                 |PCollection|    |---------|    |-----------|   |
|                 |           | -->|Transform| -->|Pcollection|   |
|                 |           |    |---------|    |-----------|   |
|Unbounded ------>|           |                                   |   
|(Stream)         |-----------|                                   |
|                                                                 |   
|------------------------------------------------------------------
            Pipeline

```
- Pcollection:
    - Data types
    - Access
    - Immutability
    - Boundedness
    - Timestamp
- Transforms => Pardo,GroupByKey,CoGroupByKey,Combine,Flatten,Partition
- Window type:
    - Single Global by default
    - Fixed
    - Sliding
    - Per Session

- Triggers:
    - Event time by default
    - Processing time
    - Data-driven
    - Composite

- Controller service account used workers and By default workers will use your projects compute engine service account as the controller service account 
- ParDo is a Beam transform for generic parallel processing. The ParDo processing paradigm is similar to the 'Map' phase of a Map/Shuffle/Reduce-style algorithm: a ParDo transform considers each element in the input PCollection, performs some processing function (your user code) on that element, and emits zero, one, or multiple elements to an output PCollection.
- Flexiable Resource Scheduling(FlexRS) 
    - Advanced scheduling
    - Cloud Dataflow Shuffle service
    - Preemptible VMs

- Cloud dataflow SQL (ZetaSQL)
    - Apache Beam SQL 
        - Query bonded and unbounded PCollections
        - Query is converted to a SQL transform

    - Cloud dataflow SQL
        - Join streams with BigQuery tables
        - Query streams or static datsets
        - Write output to bigquery for analysis and visualisation

##### IMP points
- Dataflow is an ideal managed soultion using Apache Beam
- Dataproc/Spark may be suitable for batch workload
- Beam and Dataflow are preferred solution for streaming data.
- For ad-hoc orchestration cloud composer is used


### Dataproc Architecture
- Preconfigured VM's
- cluster action completes in ~90 seconds
- Submit Hadoop/Spark Jobs
- Autoscaling,output to GCP services,monitor with stackdriver
- Single node cluster
- Standaed cluster
- High availability cluster
- Custom cluster properties
- Autoscaling is (not) good for High-availabilities,HDFS,Spark Streaming,Idle Cluster
- preemptibles can be reclaimed at any time, preemptible workers do not store data.
- Cloud Dataproc has built-in integration with BigQuery, Cloud Storage, Cloud Bigtable, Stackdriver Logging, and Stackdriver Monitoring.

### Cloud BigTable
- Managed wide-column NoSQL database
- high throughput,low latency,scalability
- Developed for Google Earth,Finance,Web indexing
- HBase open source implementation of big table model
- BigTable is (not) recommendated untill data is in TB
- A Bigtable instance can contain up to 4 clusters
- Data is never stored in Cloud Bigtable nodes themselves; each node has pointers to a set of tablets that are stored on Colossus. However, CPU resources are required for a node to manage all of its associated tablets.

### BigQuery
- High availability,standard SQL,Data source can be diffrent,Automatic backups,Governance & Security,Separation of storage and compute
- Access Web Console,command line,SDK from java,python,Go
- 4 types of Jobs 
    1. Load
    2. Export
    3. Query
    4. Copy

- Query job priority :
    1. Interactively (default)
    2. Batch

- Capacitor columnar data format
    - Proprietary columnar data storage that supports semi-structured data
    - Each value stored together with a repetition level and a definition level
- Tables can be partitioned
- Individual records exist as rows
- Supports Formats
    - CSV,JSON(newline delimited),Avro,Parquet,ORC,Cloud Datastore exports,Cloud firestore exports
- Views Users:
    - Control access to data
    - Reduce query complexity
    - Constructing logical tables
    - Ability to create authorised views
- Views Limitations:
    - Cannot export data from a view
    - Cannot use Json Api to retrive data from a view
    - Cannot combine standard and legacy SQL
    - No user defined functions
    - No wildcard table refrences
    - Limited to 1,000 authorized views per dataset
- limitation of External data
    - No gaurantee of consistency
    - Lower query performance
    - Cannot use TableDataList API method
    - Cannot run export jobs on external data
    - Cannot reference in wildcard table query
    - Query result not cached
    - Limited to 4 concurrent queries

- Other data sources:
    - Public datasets
    - Shared datasets
    - Stackdriver logs
- Partitioning --Why-->(Improve query performance & Cost Contol)
    - Ingestion Time partitioned tables
        - Partitioned by load or arrival date
        - Data automatically loaded into date-based partitions(daily)
        - Tables include the pseudo-column '_PARTITIONTIME'
        - Use '_PARTITIONTIME' in queries to limited scanned

    - Partitioned Tables
        - Partitioning based on specific TIMESTAMP or DATE column
        - Data partitioned based on value supplied in patitioning column
        - 2 additional partitions:
            - '__Null__'
            - '__UNPARTITIONED__'
        - Use partitioned column in queries

- Clustered tables:
    - Only supports for partitioned tables
    - Standard SQL only for querying clustered tables (Not lagecy SQL)
    - Standard SQL only for writing query results to clustered tables
    - Specify Clustering columns only when tables is created
    - Clustering columns cannot be modified after table creation
    - Clustering columns must be top-level,non-repeated columns
    - You can specify one to four clustering columns

- Slots 
    - Unit of computational capacity required to execute SQL queries
        - for pricing 
        - resource allocation
    - Number slots for query 
        - Query size
        - Query complexity
    - BigQuery automatically manages your slot quota
    - Flat rated pricing -> purchase fixed number of slots
    - View slots usage using Stackdriver monitoring

- Cost control
    - Avoid using SELECT * (Columns are also charged as it works on bites of data read or processes)
    - Use Preview option to sample data (preview are free)
    - Price queries before executing them
    - Using LIMIT does (not) affect cost (Whole data has to processed)
    - Partition by date
    - Materialise query results in stages
    - Streaming inserts are costly go with bulk loads
- Logging in BigQuery
```
            
BigQuery -->1. AuditData(old) (Map to API calls)
            2. BigQueryAuditMetadata(Aligned to state of BigQuery resources) --> Stackdriver -> Admin
                                                                                             -> System
                                                                                             -> Data
```
- An external data source (also known as a federated data source) is a data source that you can query directly even though the data is not stored in BigQuery. Instead of loading or streaming the data, you create a table that references the external data source.


#### Roles
- Primitive roles --> Owner,Editor,Viewer
- Predefined roles -> Granular access,Service-specific,GCP managed
- Custom roles -----> User managed

#### Cloud Data Loss Prevention API
- Fully managed service
- Identify and protect sensitive data at scale
- Over 100 predefined detectors to identify patterns,formats and checksums
- De-identifies data using masking,tokenisation,pseudonymisation,date shifting and more

#### BigQuery ML
- Types of ML can be used in BigQuery
    - Liner Regression
    - Binary logistic regression
    - Multi-class logistic regression
    - K-means clustering

### Cloud Datalab
- GCP version of Jupyter lab
- GCR Repo and store in persistent disk

### Cloud data studio
- BI Dashboards and reports

#### Data Distributions
- Discreate Variable --> Int values
- Continuous Variable -> Float value

- Bernoulli Distribution
    - Only 2 possible outcome: 0 or 1 addition of probability is 1
    - Discrete
    - Single trial
    - Probability density function:
        p(x) = ( 1 - p , x=0
               (  p    , x=1
               
- Uniform Distribution
    - Where outcome is equally likely
    - Constant probability on interval[a,b]
    - Probability density function:
        p(x) = 1/(b-a)

- Binomial Distribution
    - Discrete
    - 2 possible outcome
    - n identical trials
    - Each trial is independent of others
    - Probability density function:
        p(x) = `(n!/((n-x)!x!))p^x(1-p)^(n-x)`

- Normal Distribution
    - Mean,median and mode is equal
    - Symmetrical about µ
    - Area under the curve is 1
    - Probability density function:
        ƒ(x) = `(1/√(2πσ))e^(-1(x-µ^2)/2(σ))`

- Poisson Distribution
    - Event happens randomly
    - Generally not symmetrical about µ
    - Modelling number of times an event occurs
    - Probability density function:
        p(X = x) =`e^(-µ*(µ^x)/x!)`

- Exponential Distribution
    - the times between events in a Poisson point process
    - Probability density function:
        ƒ(x) = `λe^(-λx)` , x >= 0

### Cloud Composer (Apache Airflow)
- Directed Acyclic Graph (DAG)
- Cloud composer is Orchestration tasks with python
- Any scheduled automation task

### Machine Learning
- Google Pre-Trained models
    - Cloud Vision API
    - Cloud Video Intelligence API
    - Cloud Translation API
    - Cloud Text-to-Speech API
    - Cloud Speech-to-text API
    - Cloud Natural language API
    
- Re-useable Models 
    - Cloud AutoML
        - AutoML Vision
        - AutoML Video Intelligence
        - AutoML Natural Language
        - AutoML Natural Translation
        - AutoML Tables
- Google AI Platforms
    - Tensorflow
    - TensorFlow Extended (TFX)
    - TPU
    - Kubeflow

- Avoiding overfitting:
    - Regularization
        - l1 -> |w1|.....|wn|  -helps-> removes negative values which are not helping in generalizing vthe model
        - l2 -> (w1)^2...(wn)^2 -help-> remove small values of w to 0 to avoid overfitting
    - Increase Training Time
    - Feature Selection
    - Early Stopping
    - Cross-Validation
    - Dropout Layers

- Hyperparameters:
    - Model hyperparameters
        - Related directly to the model that is selected
        - Eg: number of hidden layer,Regularization type,Regularization rate
    - Algo hyperparameters
        - Related to the training of model
        - Eg: Batch size,Trainig epocs,Learning rate

## AI with Google
- Ai building blocks
    1. Sight
        - Vision
            - TYPES=>Synchronous Mode (Online Processing),Asynchronous Mode (Offline Processing)
            - Optical Character Recognition(OCR)-->image to text
            - Cropping hint 
            - Face Detection (Celebrrity recognition)
            - Image property Detection
            - Label detection
            - Landmark Detection
            - Explicity Content Detection (filter Safe to see images)
            - Web Entity and Page Detection
        - Video
            - Supports .mp4,.avi,.mpeg4,.mov
            - Detect label
            - Short change detection
            - Detect explicit content
            - Transcribe speech
            - Track objects
            - Detect text
            - Google Knowledge graph search api
    2. Language 
        - Translation
            - Neural Machine Translation (NMT) (not supported for all languages and its better than PBMT )
            - Phrase-Based Machine Translation (PBMT)
        - Natural Language
            - Sentiment analysis
                - Score: overall emotionality a number that ranges between -1 negative to +1 positive, 0 is mixed emotional
                - Magnitude: How much emotional content range between 0 to infinty
            - Entity analysis
            - Syntax analysis
            - Entity-sentiment analysis
            - Content classification
    3. Conversation
        - Dialogflow --> chatbot
        - Cloud Speech-to-Text API
            - Speech-to-Text can recognize multiple speakers in the same audio clip using Speaker Diarization. Use asynchronous speech recognition to recognize audio that is longer than a minute.
            - TYPES: 
                - Synchronous Recognition ->REST,gRPC
                - Asynchronous Recognition->REST,gRPC
                - Streaming Recoginition  ->gRPC bi-directional Stream
        - Cloud Text-to-Speech API
            - Speech Synthesis Markup Language(SSML)
    4. Structured Data
        - AutoML
            - AutoML vision edge 
            - AutoML translation 
            - AutoML Tables 
                - provides info of missing data
                - provides correlation,cardinality and distribution for each feature
                - automatic feature engineering
                - parallel traning of diffrent models and selecting the best
        - Recommendation API
        - Cloud Inference API


#### Difference of Bigquery ML / AutoML

|BigQuery ML| AutoML|
|-----------|-------|
|rapid iteration|optimising model quality|
|still deciding on feature to include|have time available for model optimisation|
||multifarious input feature|

### Operationalizing Machine Learning
- Process of deploying predictive models to a production environment, together with ongoing measurement,monitoring and improvement of these models.

#### Kubeflow 
- full pipeline for ml can be done using kubeflow

#### AI Platform 
- Ingest data:
    - Cloud Storage
    - Transfer service
- Prepare/Preprocess
    - Cloud Dataflow
    - Cloud Dataproc
    - BigQuery
    - Cloud Dataprep (3rd party tool by trifecta)
- Develop/train
    - Deep learning Vm
    - AI Platform notebooks
    - AI platform training
    - kubeflow
- Test/Deploy
    - Tensorflow Extended
    - AI platform prediction
    - kubeflow
- Discovery
    - AI HUB

##### AI platform or cloudML engine is the easy way to quickly run ready-to-go models in managed services ##(for exam)

## GCP Solutions
- https://gcp.solutions/



















