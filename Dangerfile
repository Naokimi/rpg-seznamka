# Warn when there is a big PR
warn("Big PR") if git.lines_of_code > 500

fail 'Please provide a summary in the Pull Request description' if github.pr_body.length < 5

rubocop.lint
