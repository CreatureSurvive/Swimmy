//
//  SiteView.swift
//
//
//  Created by Dana Buehre on 6/11/23.
//

import Foundation

public struct SiteView: Codable, Hashable {
	public let counts: SiteAggregates
	public let local_site: LocalSite
	public let local_site_rate_limit: LocalSiteRateLimit
	public let site: Site
	public let taglines: [Tagline]?
}
