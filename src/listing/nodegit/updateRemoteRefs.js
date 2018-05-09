async function updateRemoteRefs(repo) {
  await repo.fetchAll(repo.fetchOpts);
  await createLocalRefs(repo);
  const ups = await branchesAndUpstreams(repo);
  await Promise.all(ups.map(([br, up]) => NodeGit.Commit.lookup(repo, up.target())
    .then(ci => NodeGit.Reset.reset(
      repo,
      ci,
      NodeGit.Reset.TYPE.HARD,
      new NodeGit.CheckoutOptions(),
      br.toString(),
    ))));
  return repo;
}