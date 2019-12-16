//
//  ViewedArticle.swift
//  NYTClient
//
//  Created by oracool on 14/12/2019.
//  Copyright © 2019 oracool. All rights reserved.
//

import Foundation

struct MediaMetadata: Decodable {
  let format: String
  let height: Int
  let url: String
  let width: Int
}

struct Media1: Decodable {
  let approved_for_syndication: Bool
  let caption: String
  let copyright: String
  //vajno
  let media_metadata: [MediaMetadata]
  let subtype: String
  let type: String
  
  enum CodingKeys: String, CodingKey {
    case media_metadata = "media-data"
    case approved_for_syndication
    case caption
    case copyright
    case subtype
    case type
  }
}

struct ViewedArticle1: Decodable {
  let abstract: String?
  let adx_keywords: String?
  let asset_id: Int64?
  let byline: String?
  let column: String?
  let des_facet: [String]?
  let geo_facet: [String]?
  let id: Int64?
  let media: [Media1]?
  let org_facet: [String]?
  let per_facet: [String]?
  let published_date: String?
  let section: String?
  let source: String?
  let title: String?
  let type: String?
  let uri: String?
  let url: String?
  let views: String?
}


struct vaResponseBody1: Decodable {
  let status: String?
  let copyright: String
  let num_results: Int
  let results: [ViewedArticle1]
  
  enum CodingKeys: String, CodingKey {
    case status
    case copyright
    case num_results
    case results
  }
}

extension vaResponseBody1 {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.status = try container.decode(String.self, forKey: .status)
    self.copyright = try container.decode(String.self, forKey: .copyright)
    self.num_results = try container.decode(Int.self, forKey: .num_results)
    self.results = try container.decode([ViewedArticle1].self, forKey: .results)
  }
}


struct vaResponseBody: Codable {
  let status, copyright: String
  let numResults: Int
  let results: [ViewedArticle]
  
  enum CodingKeys: String, CodingKey {
    case status, copyright
    case numResults = "num_results"
    case results
  }
}

// MARK: - Result
struct ViewedArticle: Codable {
  let url: String
  let adxKeywords: String
  let column: String?
  let section, byline, type, title: String
  let abstract, publishedDate, source: String
  let id, assetID, views: Int
  let desFacet, orgFacet: [String]
  let perFacet: [String]
  let geoFacet: [String]
  let media: [Media]
  let uri: String
  
  enum CodingKeys: String, CodingKey {
    case url
    case adxKeywords = "adx_keywords"
    case column, section, byline, type, title, abstract
    case publishedDate = "published_date"
    case source, id
    case assetID = "asset_id"
    case views
    case desFacet = "des_facet"
    case orgFacet = "org_facet"
    case perFacet = "per_facet"
    case geoFacet = "geo_facet"
    case media, uri
  }
}

// MARK: - Media
struct Media: Codable {
  let type, subtype, caption, copyright: String
  let approvedForSyndication: Int
  let mediaMetadata: [MediaMetadatum]
  
  enum CodingKeys: String, CodingKey {
    case type, subtype, caption, copyright
    case approvedForSyndication = "approved_for_syndication"
    case mediaMetadata = "media-metadata"
  }
}

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
  let url: String
  let format: String
  let height, width: Int
}
