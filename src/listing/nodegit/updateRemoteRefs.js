async function updateRemoteRefs(repo) {
  await repo.fetchAll(repo.fetchOpts);
  await createLocalRefs(repo);
  const ups = await branchesAndUpstreams(repo);
  await Promise.all(ups.map(([br, up]) =>
    Reset.default(repo, up.target(), [up.toString()]);
  return repo;
}