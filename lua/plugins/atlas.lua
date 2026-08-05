require("atlas").setup({
  pulls = {
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
        },
      },
    },
  },
  issues = {
    providers = {
      jira = {
        base_url = vim.env.JIRA_BASE_URL,
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
            name = "Created",
            key = "2",
            scope = "created_by_me",
            state = "opened",
          },
        },
      },
    },
  },
})
