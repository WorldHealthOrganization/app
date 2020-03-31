package who;

// All responses are Client-independent.
// No Client instance is available in this service.
public class PublicWhoServiceImpl implements PublicWhoService {

  @Override public GetGlobalStatsResponse getGlobalStats(GetGlobalStatsRequest request) {
    // TODO: Configure cache response headers. RFC 2616 Section 9.5 says we can cache
    // POST requests.  Or we can enable GET method in present.rpc.RpcFilter.

    // TODO: Get from data source.
    return new GetGlobalStatsResponse.Builder()
      .stats(new CaseStats.Builder()
        .cases(719758L)
        .deaths(33673L)
        // 2020-03-31 10:00 CET
        .lastUpdated(1585641600000L)
        // TODO: Unsure whether we can get an efficient query for recoveries in real-time.
        .recoveries(-1L)
        .build()
      )
      .attribution("WHO")
      .build();
  }

}
