module API.Fedger.Messages.Partials where

import Data.List (List)

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