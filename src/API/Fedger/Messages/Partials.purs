module API.Fedger.Messages.Partials where

import Data.List (List)

-- | *********************** COMPANY API ***************************

data Investor = Investor {
  "type"   :: String,
  "name"   :: String,
  "slug"   :: String,
  "domain" :: String
}

data Round = Round {
  "date"      :: Int,
  "amount"    :: Int,
  "currency"  :: String,
  "round"     :: String,
  "investors" :: List Investor
}

data Location = Location {
  "city"        :: String,
  "country"     :: String,
  "iso_country" :: String
}

data Peer = Peer {
  "name" :: String,
  "rank" :: Int,
  "sim"  :: Int,
  "url"  :: String
}

data PortfolioEntry = PortfolioEntry {
  "name"   :: String,
  "domain" :: String,
  "slug"   :: String
}

data TeamMember = TeamMember {
  "urlAngellist" :: String,
  "fullName"     :: String,
  "urlTwitter"   :: String,
  "urlLinkedIn"  :: String,
  "role"         :: String,
  "lead"         :: Int
}

-- | ********************** DISCOVER API **************************

data Vertice = Vertice {
  "_id"          :: String,
  "fundingTotal" :: Int,
  "ec"           :: Int,
  "mc"           :: Int,
  "origin"       :: String,
  "slug"         :: String,
  "urlWebsite"   :: String,
  "name"         :: String,
  "type"         :: String,
  "countryCode"  :: String,
  "city"         :: String
}

data Edge = Edge {
  "_from" :: String,
  "_to"   :: String,
  "label" :: String
}

type DiscoveryData = {
  "vertices" :: List Vertice,
  "edges"    :: List Edge
}

data DiscoveryCompaniesEntry = DiscoveryCompaniesEntry {
  "_id"                 :: String,
  "_rev"                :: String,
  "_key"                :: String,
  "investorCount"       :: Int,
  "wentIPO"             :: Boolean,
  "wasAcquired"         :: Boolean,
  "dateFounded"         :: Int,
  "inCount"             :: Int,
  "outCount"            :: Int,
  "companySize"         :: String,
  "ec"                  :: Int,
  "fundingLevel"        :: Int,
  "invRatio"            :: Int,
  "fundingTotal"        :: Int,
  "mc"                  :: Int,
  "urlAngellist"        :: String,
  "slug"                :: String,
  "name"                :: String,
  "urlSlug"             :: String,
  "origin"              :: String,
  "fundingCurrencyCode" :: String,
  "phone"               :: String,
  "urlTwitter"          :: String,
  "urlCrunchbase"       :: String,
  "urlWebsite"          :: String,
  "descShort"           :: String,
  "descFull"            :: String,
  "type"                :: String
}

-- | ********************* GEO API ***************************

data GeoLocatedCompany = GeoLocatedCompany {
  "dateFounded"   :: Int,
  "fundingLevel"  :: Int,
  "phone"         :: String,
  "slug"          :: String,
  "urlCrunchbase" :: String,
  "urlAngellist"  :: String,
  "urlWebsite"    :: String,
  "urlTwitter"    :: String,
  "name"          :: String
}

data GeoLocatedFunding = GeoLocatedFunding {
  "company"  :: String,
  "investor" :: String,
  "amount"   :: Int,
  "currency" :: String,
  "date"     :: Int,
  "round"    :: String
}

-- | ********************* NEWS API ****************************

data LatestFunding = LatestFunding {
  "date"      :: Int,
  "amount"    :: Int,
  "currency"  :: String,
  "round"     :: String,
  "name"      :: String,
  "slug"      :: String,
  "domain"    :: String,
  "investors" :: List Investor --<<-- same Investor-Type as in Company API
}

-- | ********************* TAGGED API *************************

data TaggedCompany = TaggedCompany {
  "dateFounded"   :: Number,
  "fundingLevel"  :: Int,
  "slug"          :: String,
  "name"          :: String,
  "phone"         :: String,
  "urlTwitter"    :: String,
  "urlCrunchbase" :: String,
  "urlWebsite"    :: String,
  "urlAngellist"  :: String
}

data TaggedFunding = TaggedFunding {
  "company"  :: String,
  "investor" :: String,
  "amount"   :: Number,
  "currency" :: Number,
  "date"     :: Number,
  "round"    :: String
}