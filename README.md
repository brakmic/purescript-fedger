## purescript-fedger

This is a small collection of bindings for accessing the publicly available <a href="https://fedger.io/" target="_blank">Fedger.io</a> APIs.
Simply register with your E-Mail to obtain a free API-Key.

To make the testing easier there's a small <a href="https://github.com/brakmic/purescript-fedger/blob/master/demo/scripts/app.purs">Demo App</a> available.

#### What's the purpose of this library?

Fedger collects and provides information about companies by using machine learning. And because I'd like to learn more about ML *in practice* (<a href="http://blog.brakmic.com/data-science-for-losers-part-4-machine-learning/">and also</a> have <a href="http://blog.brakmic.com/data-science-for-losers-part-6-azure-ml/">written</a> a <a href="http://blog.brakmic.com/data-science-for-losers-part-6-azure-ml/">few articles</a>
on <a href="http://blog.brakmic.com/data-science-for-losers-part-7-using-azure-ml">this subject</a>) I thought it might be useful to have a *strongly typed* and *side-effect-free* library for ML.

Of course, it's not a secret that I'm a happy **PureScript-Noob** already maintaining two *<a href="https://github.com/brakmic/purescript-ractive">pet</a> <a href="https://github.com/brakmic/purescript-redux">projects</a>* based on PureScript but they have nothing in common with ML.

So, Fedger.io is really perfect for me....*Machine Learning* **and** *PureScript* in one. :smile:

#### Current status

All of <a href="https://dev.fedger.io/docs" target="_blank">the APIs</a> are available as `foreign imports`.

<img src="http://fs5.directupload.net/images/160124/l4lkzk6q.png">

The Fedger API comprises of following sub-APIs:

- Company API
- Discover API
- Geo API
- News API
- Stats API
- Tagged API

The Requests & Responses also have their strongly typed counterparts located in **API/Fedger/Messages**

#### Using the API

For example, here are the type definitions for `getCompanySnapshot`:

*Query*

```haskell
data CompanySnapshotQuery = CompanySnapshotQuery {
  domain :: String,
  apikey :: String
}
```

*Response*

```haskell
data CompanySnapshotResponse = CompanySnapshotResponse {
  "domain"        :: String,
  "name"          :: String,
  "slug"          :: String,
  "phone"         :: String,
  "dateFounded"   :: String,
  "fundingLevel"  :: String,
  "urlTwitter"    :: String,
  "urlLinkedIn"   :: String,
  "urlAngellist"  :: String,
  "urlCrunchbase" :: String
}
```

To call this API we use:

```haskell
foreign import getCompanySnapshot :: forall e. CompanySnapshotQuery -> (CompanySnapshotResponse -> Eff e Unit) -> FedgerEff Unit
```

This is how a JSON-result looks like in the console:


<img src="http://fs5.directupload.net/images/160122/hrssqbir.png">

Now we convert it to something more stable and reliable, a PureScript **Type**. :smile:

This is the **callback** Function.

Because all of the API queries are asynchronous a callback must be provided by default. Currently,
I'm using some <a href="http://api.jquery.com/jquery.ajax/" target="_blank">jQuery.ajax()</a> and <a href="http://www.html5rocks.com/en/tutorials/es6/promises/?redirect_from_locale=de#toc-lib-compatibility" target="_blank">convert</a> the jQuery 'Deferred' into a Promise.

```haskell
companySnapshotCB :: forall e. CompanySnapshotResponse -> Eff (console :: CONSOLE | e) Unit
companySnapshotCB = \(CompanySnapshotResponse r) -> do
                                                    log ("Company: "       ++ r.name          ++ "\r\n" ++
                                                         "Funding Level: " ++ r.fundingLevel  ++ "\r\n" ++
                                                         "Slug: "          ++ r.slug          ++ "\r\n" ++
                                                         "Twitter: "       ++ r.urlTwitter    ++ "\r\n" ++
                                                         "Crunchbase: "    ++ r.urlCrunchbase ++ "\r\n")
```

This is the **main** function.

We define a **Query Type** and fill it with data from a company we're searching for. Then we apply `getCompanySnapshot` to the data and callback from above.

```haskell
main ::  forall e. Eff (console :: CONSOLE, fedgerM :: FedgerM | e) Unit
main = do
      let snapshotQuery = CompanySnapshotQuery { domain : "giantswarm.io", apikey : YOUR_API_KEY_HERE }
      getCompanySnapshot snapshotQuery companySnapshotCB
```

This is the result:

<img src="http://fs5.directupload.net/images/160122/acqut34b.png">

#### Building

*Backend*

```shell
npm install [initial build only]
pulp dep install [initial build only]
gulp
```

*Frontend*

```shell
gulp make-demo [*initial build only*]
gulp build-demo
```

*Complete rebuild + cleanup*

```shell
gulp clean && gulp && gulp build-demo
```

#### Running the Demo App

```shell
npm start
```

<a href="http://hapijs.com/" target="_blank">HapiJS</a> will start to serve pages on <a href="http://localhost:8080">http://localhost:8080</a>

#### Issues / Important notices

**Problem 1)**

During my API tests I found some discrepancies between the docs and the actual response objects. For example, the docs for <a href="https://dev.fedger.io/docs/#!/company/get_company_company_domain_funding_details" target="_blank">getFundingDetails</a> describe the
response object as

```javascript
{
  "domain": "string",
  "total_fund": 0,
  "currency": "string",
  "rounds": [
    {}
  ]
}
```

...but the actual response object's structure is like this:

```javascript
{
  "name": "",
  "domain": "",
  "amount_total": 0,
  "rounds": []
}
```

There's no field `total_fund` but `amount_total` instead. Also, there's no `currency` property at all!

**Problem 2)**

Accessing `getFundings` from the Company API yields an *HTTP 500-Error*.

```json
{
  "statusCode": 500,
  "error": "Internal Server Error",
  "message": "An internal server error occurred"
}
```

#### License
<a href="https://github.com/brakmic/purescript-fedger/blob/master/LICENSE">MIT</a>