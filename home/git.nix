{ ... }:
{
  programs.git = {
    enable = true;
    
    settings = {
      user = {
        name = "themngn";
        email = "themngn@example.com";
      };

      alias = {
        a = "add";
        aa = "add --all";
        ap = "add --patch";
        br = "branch";
        brd = "branch --delete";
        c = "commit";
        ca = "commit --amend";
        cam = "commit --amend --no-edit";
        cm = "commit --message";
        co = "checkout";
        cob = "checkout -b";
        d = "diff";
        dc = "diff --cached";
        dw = "diff --word-diff";
        f = "fetch";
        fa = "fetch --all";
        fo = "foreach";
        l = "log --oneline";
        ll = "log --oneline --graph --all";
        lgs = "log --oneline --stat";
        lp = "log --patch";
        ls = "log --shortstat";
        p = "push";
        pf = "push --force-with-lease";
        pl = "pull";
        plr = "pull --rebase";
        ps = "push --all";
        r = "reset";
        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        ri = "rebase -i";
        rh = "reset --hard";
        s = "status";
        sh = "show";
        st = "stash";
        sta = "stash apply";
        stl = "stash list";
        sts = "stash save";
        t = "tag";
      };

      core = {
        editor = "nvim";
        whitespace = "trailing-space,space-before-tab";
      };
      
      push = {
        default = "current";
      };
      
      pull = {
        rebase = true;
      };
      
      merge = {
        conflictStyle = "diff3";
      };
      
      init = {
        defaultBranch = "main";
      };
      
      diff = {
        algorithm = "histogram";
      };
    };
  };
}
