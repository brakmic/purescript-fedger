module API.Fedger.Messages.Queries where

-- | ******************* COMPANY API *********************************

data FundingDetailsQuery = FundingDetailsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data FundingStatusQuery = FundingStatusQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data FundingsQuery = FundingsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data CompanyInsightsQuery = CompanyInsightsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  classes     :: String,
  cursor      :: Int
}

data CompanySnapshotQuery = CompanySnapshotQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data InvestorsQuery = InvestorsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data LocationsQuery = LocationsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data PeersQuery = PeersQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data PortfolioCompaniesQuery = PortfolioCompaniesQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data TeamDetailsQuery = TeamDetailsQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data LogoQuery = LogoQuery {
  domain      :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

-- | ************************* DISCOVER API ************************

data DiscoveryQuery = DiscoveryQuery {
  s           :: String,
  apikey      :: String,
  crossDomain :: Boolean
}

data DiscoveryCompaniesQuery = DiscoveryCompaniesQuery {
  s           :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}

data DiscoveryVerticesQuery = DiscoveryVerticesQuery {
  s           :: String,
  apikey      :: String,
  crossDomain :: Boolean,
  cursor      :: Int
}