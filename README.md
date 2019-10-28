# Demo-GitSec

This demo is based off the opensource project truffle hog and has been adapted for use as a githook in order to demonstrate the potential usefullness of githooks in applying security or code quality rules.

# Tutorial

## Requirements
- Internet access
  - Github/Gitlab account
- Laptop/Desktop/Cloud Workspace
  - Bash
  - Python
  - Git

## Steps
- ### Fork and Checkout repo 
  In order to edit and push back to the repo you should first fork the gitlab/github repo under your credentials, the urls are below. <br>
  - https://github.com/kempy007/Demo-GitSec.git 
  
  Then you just need to run ```git clone PASTE_GIT_URL_HERE``` replace with your forked repo URL.
- ### Install githooks 
  change directory to gitHookLocal and run the install script ```./install.sh``` <br> This will check python is installed and install the scripts into to local repo .git/hooks folder (this folder will not be commited to git). <br> Tip! they could be installed into the global git hooks folder instead if you wanted this accross projects.
- ### Add secret file
  Change directory back to the base folder and run the decode script ```./decode.sh``` <br> This should create a newfile private.key in the root directory.
- ### Commit file attempt 1
  If we run a lazy git add ```git add .``` followed by a status check ```git status``` We should see the new private.key is staged. <br> If we run ```git commit -m "Whoops private key..."``` we should see a warning message that the key was found and another ```git status``` will show the file staged.
- ### Commit file attempt 2
  We can override the commit with the no verify switch -n ```git commit -n -m "Whoops private key..."``` now when we run ```git status``` we shouldn't see the file staged anymore.
- ### Push attempt 1
  No that we have got the file staged and over ridden the commit, we need to push the changeset back to the origin server with ```git push``` Again we should see a warning message and the push effectively blocked, you can verify this on gitlab/github.
- ### Push attempt 2
  To override this we need to remove the pre-push file from ./git/hooks, then we can run ```git push``` this time it will succeed and we should see the commit on gitlab/github.
- ### How to handle a breach
  Once you have discovered any secrets have been accidentally published you should immediately request rotation of the secrets affected to ensure they cannot be used by an adversary any longer. We have to assume they are now known to the rest of the world. <br>
  Secondly you should raise a security incident so the matter can be followed up by an incident responder who will check for unauthorised use, and maybe monitor the accounts for any attempts to use the old credentials, try to establish a time window the credentials were exposed for by checking through the commit history.

- ### How to cleanup the breach
  Essentially we have to rebase the repo and remove all the affected commits before forcing a push to origin, there are issues to be considered such as open pull and merge requests and the commit SHA's could be recalculated breaking any tags, so it's best to avoid this situation by using githooks without overriding them. <br>
  run ```git log``` to show each commit and the SHA hash, copy the initial commit hash and then run ```git rebase -i PASTE_HASH_HERE``` <br>
  Your default text editor should popup or be displayed. you should remove the line/lines with the commit containing the secret, then save the file and exit the editor. <br>
  now we run ```git push origin master -f``` you can verify the bad commit is no longer on gitlab/github.





## Issues
- Proxy TLS intercept Issue, add to Git cmd: ``` -c http.sslVerify=false ```



## References
- https://githooks.com/
- https://stackoverflow.com/questions/40245767/delete-commit-on-gitlab
