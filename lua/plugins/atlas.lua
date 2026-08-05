require("atlas").setup({
  pulls = {
    repo_config = {
      paths = {
        ["struktur/kubernetes"] = vim.fn.expand("~/Documents/rf/struktur/k8s"),
        ["struktur/gitops"] = vim.fn.expand("~/Documents/rf/struktur/gitops"),
      },
      settings = {
        ["struktur/kubernetes"] = {
          pr_template = ".gitlab/merge_request_templates/Default.md",
        },
        ["struktur/gitops"] = {
          pr_template = ".gitlab/merge_request_templates/Default.md",
        },
      },
    },
    providers = {
      gitlab = {
        base_url = "https://gitlab.dnm.radiofrance.fr",
        token = vim.env.GITLAB_TOKEN,
        cache_ttl = 300,
        views = {
          {
            name = "Assigned",
            key = "1",
            scope = "assigned_to_me",
            state = "opened",
          },
          {
            name = "Reviewing",
            key = "2",
            scope = "all",
            extra_params = { reviewer_id = "Me" },
          },
          {
            name = "Ready for Review",
            key = "3",
            scope = "all",
            state = "opened",
            draft = false
          },
        },
      },
    },
  },
  issues = {
    providers = {
      jira = {
        base_url = "https://dnm-radiofrance.atlassian.net",
        email = vim.env.JIRA_EMAIL,
        token = vim.env.JIRA_TOKEN,
        auth_method = "basic",
        api_type = "cloud",
        cache_ttl = 300,
        views = {
          {
            name = "My Open",
            key = "M",
            layout = "plain",
            jql = "assignee = currentUser() AND statusCategory != Done ORDER BY updated DESC",
          },
        },
      },
    },
  },
})
