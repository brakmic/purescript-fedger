module API.Fedger.Messages.Queries where

data FundingDetailsQuery = FundingDetailsQuery {
  domain :: String,
  apikey :: String
}

data FundingStatusQuery = FundingStatusQuery {
  domain :: String,
  apikey :: String
}

data FundingsQuery = FundingsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Int
}

data CompanyInsightsQuery = CompanyInsightsQuery {
  domain  :: String,
  apikey  :: String,
  classes :: String,
  cursor  :: Int
}

data CompanySnapshotQuery = CompanySnapshotQuery {
  domain :: String,
  apikey :: String
}

data InvestorsQuery = InvestorsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Int
}

data LocationsQuery = LocationsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Int
}

data PeersQuery = PeersQuery {
  domain :: String,
  apikey :: String
}

data PortfolioCompaniesQuery = PortfolioCompaniesQuery {
  domain :: String,
  apikey :: String,
  cursor :: Int
}

data TeamDetailsQuery = TeamDetailsQuery {
  domain :: String,
  apikey :: String,
  cursor :: Int
}

data LogoQuery = LogoQuery {
  domain :: String,
  apikey :: String
}