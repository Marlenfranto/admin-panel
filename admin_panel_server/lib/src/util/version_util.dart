import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

/// Atomically increments the [Organization.contentVersion] for [organizationId].
///
/// Call this after any mutation to modules, content, or assets so that
/// external clients can detect stale cached data on their next login.
Future<void> bumpOrgContentVersion(
  Session session,
  int organizationId,
) async {
  final org = await Organization.db.findById(session, organizationId);
  if (org == null) return;
  org.contentVersion = org.contentVersion + 1;
  await Organization.db.updateRow(session, org);
}
