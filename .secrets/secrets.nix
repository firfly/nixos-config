let
#  users = import ~/.ssh/authorized_keys;

  lenovo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBSojalXFh4+wuA20jhbfe5nUnaHuqHkheEBFRvcHdVW";
  firfly = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFnLBC/wJR38rSHeIqsK1YxliaZNNXvJtLqmiRCsWe8z";
  users = [ lenovo firfly ];

  mbp_company = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAwUZyiKlXoR+MlhptIIbWLmZY50/pLQMHNwdL2SCnej";
  systems = [ mbp_company lenovo firfly ];
in
{
  "user-password.age".publicKeys = users;
  "system-password.age".publicKeys = systems;
  "secret.age".publicKeys = users ++ systems;
  "identity.age".publicKeys = users ++ systems;
}
