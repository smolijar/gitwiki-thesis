async function updateRemoteRefs(repo) {
  await repo.fetchAll(repo.fetchOpts);
  await createLocalRefs(repo);
  const ups = await branchesAndUpstreams(repo);
  await Promise.all(ups.map(branchAndUpstream =>
    repo.mergeBranches(...branchAndUpstream.map(getRefCompoundName))));
  return repo;
}