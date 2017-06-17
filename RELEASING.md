## Releasing a new version of the engine

1. Update documentation snippets from Haml-Lint. We extract the examples from the repository by running the following Rake task: `rake docs:scrape`. Double-check the output to make sure the scraping worked properly.
2. Categorize any new linter in the `CC::Engine::Categories::CATEGORIES` map.
3. Add remediation points for any new linter in the `CC::Engine::RemediationPoints::POINTS` map.
4. Increment the version number of the engine in `engine.json`. If you’re making a change to the engine and not updating the version of Haml-Lint, increment the `-X` tag. Otherwise, update version number to match the new version of Haml-Lint and set the tag to `-1`.
5. Update the changelog with any missed changes.
6. Tag the version of the engine with `git tag -m “Version X.YY.Z-N” vX.YY.Z-N` and push the tag up to GitHub.
