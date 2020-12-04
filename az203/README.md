#### Get https://github.com/linuxacademy/content-az203-files
### Batch services
- Iaas offering, large scale parallel and hpc jobs
- Common uses:
    - Monte-carlo simulation / finanical risk
    - VFX and 3D rendering
- Components:
    - Storage account ( holds input/output )
    - Batch account ( top level container )
    - Pools ( vm size and quantity )
    - Jobs ( logical group for tasks )
    - Tasks ( actual items for work )


##### Main is order in exam
1. az batch pool create
2. az batch job create
3. az batch task create


##### Eg:
```
$rgname = "batch"
$stgAccName = "laaz203batch"
$location = "westus"
$batchAcctName = "lazz203batchaccountname"
$poolName = "mypool"

az group create 
    -l $location -n $rgname

az storage account create 
    -g $rgname  -n $stgAcctName
    -l $location --sku Standard_LRS

az batch account create
    -n $batchAcctName  --storage-account $stgAcctName
    -g $rgName -l $location

az batch account login 
    -n $batchAcctName -g -g $rgName --sgared-key-auth

az batch pool create
    --id $poolName
    --vm-size Standard_A1_v2
    --target-dedicated-nodes 2
    --image canonical:ubuntuserver:16.04-LTS
    --node-agent-sku-id "batch.node.ubuntu 16.04"

az batch pool show
    --pool-id $poolName
    --query "allocationState"

az batch job create
    --id myjob
    --pool-id $poolName

for ($i=0;$i -lt 4;$i++){
        az batch task create
            --task-id mytask$i
            --job-id myjob
            --command-line "/bin/bash  -c 'printenv| grep AZ_BATCH:sleep 90s'"
}

az batch task show
    --job-id myjob
    --task-id mytask1

az batch task file list
    --job-id myjob
    --task-id mytask1
    --output table

az batch task file download
    --job-id myjob
    --task-id mytask1
    --file-path stdout.txt
    --destinnation ./stdout.txt
```

#### Containers 
```
FROM <OS>
WORKDIR /app

COPY <Machine>/* <./app>
RUN python manage.py collectstatic

ENTRYPOINT ["python","manage.py","runserver :80"]
```


```
docker build -t tag-django 
docker run -d -p 8000:80 --name myapp webapp
                 <local>:<internal>
docker ps -a
```
##### Azure kubernetes Service(AKS)
- https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app

- https://github.com/Azure-Samples/azure-voting-app-redis

- Get yaml file from github
- Commands
    1. Variables
        ``` 
        $rg = "aksdemo"
        $cluster = "akscluster"
        ```
    2. Create Resource group
        ```  
        az group create -n $rg --location westus
        ```
    3. Create Cluster
        ```  
        az aks cluster -g $rg -n $cluster --node-count 1
            --generate-ssh-keys
        ```
    4. Create Credentials
    ```
        az aks get-credentials -g $rg -n $cluster
    ```
    5. Get cluster nodes
    ```
        Kubectl get nodes
    ```
    6. Apply Application
    ```
        kubectl apply -f aks/azure-vote.yml
    ```
    7. Wait for Development 
    ```
        kubectl get service azure-vote-front --watch
    ```
##### Imp for exam

- Docker 
    - FROM -> WORKDIR -> COPY -> ENTRYPOINT
- az aks commands and parameters

- Reference Aks app and docker docs

#### Table Store (cheaper than cosmos but cosmos isbest)
- Create storage table
    1. Variables                #check above
        ` $acct = "laaz203tables" `
    2. ` az group create         #check above `
    3. ` az storage account create      #check above `
    4. `
        az storace account show-connection-string
            - n $acct --query "ConnectionString"
        `
    5. ` az group delete -n $rg `


- Check table store docs
    - CRUD and basic query

#### Cosmos db
- Create cosmos db

    1. variables        #check above
    2. az group create  #check above
    3. Create cosmos db account
      `  
        az cosmosdb create -g $resourceGroupName
        --name $accountname --kind GlobalDocumentDB
        --location "West US=0" "North Central US=1"
        --default-consistency-level Strong
        --enable-multiple-write-locations true
        --enable-automatic-failover true
        `
    4. Create database
      `  
        az cosmosdb database create 
            -g $resourceGroupName --name $accountname
            --db-name $databaseName
        `
    5. Retrieve account keys
       ` 
        az cosmosdb list-keys --name $accountName
            --g $resourceGroupName
        `
    6. Retrieve connection string
        `
        az cosmosdb list-connection-string 
            --name accountName -g resourceGroupName
        `
    7. Retrieve Primary Endpoints
        ```
        az cosmosdb show --name $accountName 
            -g $resourceGroupName --query "documentEndpoint"
        ```
##### Imp for exam
- Consistency ^
- SQL API
- Cli to create db 

#### BLob storage
- Create blob storage

    1. variables
    2. `az group create -n $rg  -l $location`
    3. ` 
        az storage account create 
        -g $rg -n  $account -l $location 
        --sku Standard_LRS 
        `
    4. `
        az  storage account show-connection-string
            -n $account --query "connectionString"
        `

- lease means locking
- concurency cintrols 
- c# using Blog control


#### Web app
- unique in .net domain
- F1 free, shared infra no deployment slots,no custom domain,no scaling
- D1 shared infra no deployment slots,custom domain,no scaling
- B1 shared infra no deployment slots,custom domain SSl, custom scaling

```
1. set variable
    
    $rg="webapp"
    $planname="githubdeployasp"
    $appname="laaz203githubdeploy"
    $repourl="github.com/azureexample/heloworld.git"

2. create Resource group

    az group create 
        -n $rg -l westus

3. Create App service Plan

    az appservice plan create 
        -n $planname -g $rg
        --sku FREE

4. Create Web App

    az webapp plan create 
        -n $appname -g $rg 
        --plan $planname

5. Configure Github Deployment

    az webapp deployment source config
        -n $appname -g $rg --repo-url $repourl
        --branch master 
        --manual-intregation

6. Show webapp
    
    az webapp show -n  $appname -g $rg
        --query "defaultHostName" -o tsv

    az webapp deployment source sync -n $appname -g $rg 

6. Retrive Content

    echo http://$appname.azurewebsites.net

```

##### Webapp using docker
- Same as github but 
```
1. variable
2. create group
3. create app sevice plan
    # using B1 rather than free

    az webapp create -n $appname
        -g $ rg --sku B1 --is-linux

4. craete web app
    
    az webapp create -n $appname -g $rg 
        --plan $planname --deployment-container-image-name $container

5. Configure github deployement 

    az webapp config appsettings set 
        -g $rg -n $appname --settings WEBSITE_PORT=80

6. Show webapp

```

###### Imp for exam
- az group create
- az app service plan create
- az webapp create
- sequience and all

- Eg :
    ```
PowerShell script to create Linux App Service plan:

    $resourceGroup = az group list --query '[0].name' --output json
    $appServicePlan = 'Linux-App-ServicePlan'

    az appservice plan create -g $resourceGroup -n $appServicePlan --is-linux --number-of-workers 1 --sku B1


PowerShell script to create file shares:

    $app = 'LinuxDockerApp' + (Get-Date).ticks

    az webapp create --resource-group $resourceGroup --plan $appServicePlan --name $app --deployment-container-image-name microsoft/dotnet-samples:aspnetapp


PowerShell script to create file shares:
    az webapp config container set --resource-group $resourceGroup --name $app --docker-registry-server-url 'https://github.com/dotnet/dotnet-docker/tree/master/samples/aspnetapp'

```

#### Create mobapp service
* if offline
- new MobileServiceClient(Constants.ApplicationUrl) # for reconnecting and authentication, authorization

- this.client.SyncContext.InitializeAsync(store) #sync local and cloud db

- client.GetSyncTable<TodoItem>() # to get the list from local sqlite db

* when online

- client.GetTable<ToItem>(); # when online get data from cloud
    

##### Sequence of implementing offline data sync
- push the pull ## always
- enable offline sync from ms docs

#### Azure Functions(Serverless computing)

- que =to> funtion =to> storage db

* [FuntionName("same function name ")] ## annotiate with Function so at runtime it can be determined this is a azure function

* the fuction takes QueryTrigger,CloudQueuemessage, Table , ICollector, ILogger
* eg:
    ```
    public static class OrederProcessor{
        [FuntionName("ProcessOrders")]
        public static void ProcessOrders(
               [QueryTrigger("incoming-orders",
                      Connection="AzureWebStorage")],
               CloudQueuemessage queItem,
               [Table("Orders",Connection="AzureWebJobsStorage")]
               ICollector<Order> tableBinding,
               ILogger log)
                {
                   
                    table.Bindings.Add(Json.DeserializeObject<order>(que) )

                }
    }

```
- to create que
```
1. var
2. az group create
3. az storage account create
4. $key = $(az storage account key list1
            --account-name $acc
            -g $g 
            --query "[0].value"
            --output tsv)
5. az storage queue create
    -n $queue
    --account-name $acc
    --account-key $key

6. az storage account show-connection-string
    -n $acc
    --query "connectionStrinng"
    
7. $order1json = Get-Content -Path order1.json

8. az storage message put
    --account-name $acc
    --account-key $key
    --queue-name $queue
    --content $order1json

9. az group delete -n $rg -y


```
#### Scaling of Function
- function can get upto 16 messages which will run a vm and processed parallel it is all taken care by azure function 

- Kind of sliciding window 
- 16 parallel  process and 24 parallel message can be pulled from que by fucntion
- message will be process once if fails it will retry 4 times then function will create posion table and store the message there

##### Imp for exam
- function with [QueryTrigger] attribute process Store Queue message
- [Table]
- 16 parallel process 
- retry 4 times before creating posion table.
- Check triggers from docs


#### App service Logic app
- create storage account , create que 
- retry option
    - Default
    - Exponenntial interval
    - Fixed interval
    - None

##### Exam tips (check tge docs)
- logic apps are good for event driven processes that integrate with other service .
- They are declarative instead of code first
- Functions are light weight and code-first
- for processing que messages functions are best (for exam)
- Webjob are able to run in the same azure devops as webapps


#### Azure Search
- to create
    ```
    1. variable
    2. az  group create
    3. az search service create 
        --name  $serviceName -g $rg
        --sku free
    4. az search admin-key show
        --service-name $serviceName
        -g $rg --query "primaryKey"
    5. az search query-key list
        --service-name $serviceName -g $rg
        --query "[0].key"

    6. az group  delete -n  $rg --yes

    ```
- Check the docs for basic  index and search c# query

- Operation related to managing indexes are preformed using "SearchServiceClient" object

- Search of an index is preformed using a "SearchIndexClient" object
- Use "SearchCredentials" object to specify authorization credentials for both SearchServiceClient and SearchIndexClient 

- Create index "SearchServiceClient().Indexes.Create(<defination>)"
- Prepare a batch of doc for upload with the static method "IndexBatch.Upload(<document collection>)"

- Upload document returned from IndexBatch.Upload with SearchIndexClient().Documents.Index(<batch returned from upload>)

- perform search with "SearchIndexClient().Document.Search<T>(<query>,<parameter>).

- if result are missing in the search then make sure the properties your are searching are "Searchable" if not drop the index recreate it with the field set as "Searchable" You cannot change this without droping or rebuiliding of the index

- the exam may refer to uploading table data into the index. this is possible but not required for any question/answer

#### Api management serivce
- type of policy check in doc
- validate-jwt,openid in doc

#### Event grid
- to create event grid
    - when blob is created it will triger the event
```
    1. variable
    2. az group create
    3. az storage account create
    4. az storage account key  list

    5. ngrok http -host-header=localhost 5000

    6. $funcappdns = "00d2bcb.ngrok.io"
       $viewrederpoinnnt = "https://$funcappdns/api/updates"
       $storageid = $(az storage account show
                       -n $stgacctname -g $rgname
                       --query id --output tsv)
       az eventgrid event-subscription create
            --source-resource-id $storageid
            --name storagesubscription
            --endpoint-type Webhook
            --enpoint $viewrenderpoint 
            --include-evennt-types "Microsoft.Storage.BlobCreated"
            --subject-begins-with "/blobService/default/containners/testcontainer/"


```
##### hints:
- Commo means of consuming events is with WEBhooks and that as ASP.Net MVC Webhook event handler
- Events are set to topic they are delevered to all subscribers of the topic
- A subscripition ca have rules to select messages send to the topic
- exam may ask about creating topics for 2 event handler 1 is web hooks

- Read abot JSON forconfigurinng a blob created event subscription 

#### Service bus(MaaS)
ReplyTo,ReplyToSessionId,MessageID,CorrelationID,SessionId
- to create service bus
```
    1. az group create -n servicebus-1 -l westus
    2. az servicebus namespace create --n laz203 -g servicebus-1
    3. az servicebus namespace authorization-rule keys list
        -g servicebus --namespace-name laz203 
        --name RootManagerSharedAccessKey
        --query primaryConnectionString
    4. az servicebus queue create --namespace-name laz203
        -g servicebus-1 -n testqueue
    5. New-AzureRmServiceBusQueue
        -ResourceGroupName servicebus
        -NamespaceName laz203 -name testqueue
        -EnablePatitioning $false
```

##### imp
- how to create queue cli
- routing,reply pattern 

### Security
#### azure serice principal (App regristration)

- to create serice principal(App regristration)
```
    $spname = "laz203"
    $sp = az ad sp create-for-rbac --name $spname
    az ad sp show --id $sp.appID
    az ad sp list --display-name $spname

    az role assignment list --assignee $sp.appId

    az role definition list 

    az  role assignment create 
        --role "Website Contributor"
        --assignment $sp.appId
        --scope $sampleweb.Id

    az role assignment delete --assigee $sp.appId 
        --role "Contributor"

    az ad delete --id $sp.appId

```

#### Key vault
- to create 
```
    1. az group create
    2. az keyvault create -n "name" -g "resource" --sku stanndard
    3. az keyvault secret set 
        --vault-name $kvname
        --name "connectionString"
        --value "this is the connecting string"

    4. az keyvault secret show
        --vault-name $knanme
        --name connecetionString

```

#### Masking data
- imp check docs SuffixSize and PrefixSize
- to create mask
    ```
    Thats the exact command:-
    1. New-AzureRmSqlDatabaseMaskingRule
        -ResourceGroupName $rgname
        -Servicename $serviceName
        -DatabaseName $dbname
        -SchemaName "db"
        -TableName "Users"
        -ColumnName "AccountCode"

    ```
#### Always Encrypted
- certificate is created to get access or to decrypt only special column or table 

#### aks
```
    1. az aks create
        --resource-group "<resource>"
        --name "name" 
        --generate-ssh-keys
        --aad-server-app-id "<svr-app-id>"
        --aad-server-app-secret "<svr-app-secret>"
        --aad-client-app-id "<client-app-id>"
        --aad-tenant-id "<tenant id>"

    2. az aks get-credrntials
        --resource-group "<resource>"
        --name "name" 
        --admin

    3. kubectl apply -f rbac-add-user.yal

```

#### Logging
- to start logging
```
    az webapp log config
        -n $name -g $resourcegroup
        --level information
        --application-logging true
    
    # In Code
    Add 
    .ConfigureLogging(logging =>
    {
        logging.AddAzureWebDiagnostics();
    })
```

#### Usage Analytics
- feature | Primary Capability
- funnel  | track progression of user
- Impcat  | how do page load times and other properties influence coversio rate
- Retention | How may users return and how often do they perform task
- User Flows | Shows how users avigate betwee pages and feature


#### Azure autoscale

#### Azure redis cache
- to increase -session state






















