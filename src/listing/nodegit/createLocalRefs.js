async function createLocalRefs(repo) {
  const references = await repo.getReferences(NodeGit.Reference.TYPE.LISTALL);
  const remoteRefs = references.filter(r => r.isRemote());
  return Promise.all(remoteRefs.map((remoteRef) => {
    const oid = remoteRef.target();
    const upstreamName = getRefCompoundName(remoteRef.toString());
    const { name } = parseRefName(remoteRef.toString());
    return getOrCreateBranch(repo, name, oid)
      .then(b => NodeGit.Branch.setUpstream(b, upstreamName));
  }));
}