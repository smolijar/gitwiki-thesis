# User access

As mentioned before, there are some fatal decisions on the table to be made, that must be resolved before even defining the system through standard tools, such as requirement model.
That is, how are the documents going to be persisted, and how users are going to access it.

To this moment in order to stay in the abstract conceptual level, which was convenient for e.g. business process modeling,
I never implied a specific VCS to use within the system, though it is given in thesis description.
Git VCS shall be used to wiki contents persistence, as given in the task.
It has many advantages, including branch model, CLI repository access via SSH and it is decentralized, which might be of convenient for Dump and Lump to work out of the office.
Apart from that, it is fairly popular.
According to [@openhub:vcs] up to 50% of existing open source projects use Git, while the second place goes to Subversion with 42%.
That goes only for open source projects.
Most of the statistics reflecting global usage of VCS are thus misleading, and in global scope with private projects Subversion still rules over Git with usage statistics.
From various sources, e.g. mentioned in [@stackexchange:vcs], it is apparent that Git's popularity is increasing over the years, which makes Git a reasonable choice.

Using Git as an underlaying VCS layer brings two important questions to discuss.

1. Access control gets more complicated.
In centralized VCSs, it is natural to have the feature of file locks, which is e.g. available in Subversion.
Though there are tools to simulate this in Git, it gets far more challenging.
How do we solve access control within a Git repository?

2. Git provides a useful interface for repository cloning, granting us an elegant solution for direct file access, familiar to Dump, Lump and Pump.
Users are authenticated through SSH authentication layer, once they deliver their public keys to the hosting server, which is a standard practice used by popular git hosting providers.
The question is, how do we authenticate the user in WUI and pair them with their stored public key?