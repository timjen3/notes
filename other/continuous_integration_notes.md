# continuous integration notes

Link: https://telusagri.udemy.com/course/ci-cd-devops/learn/lecture/17812622#overview

Lots of issues with the "old school" method of branch -> test -> merge
1. integration is painful
2. fixing issues at end of iterations
3. merge issues cause broken builds
4. long feedback cycles
5. long iterations - weeks to months

Continuous integration:
* Use branches for your code, but merge to master frequently. as often as multiple times a day
* Don't wait for a build & integration team to merge your code. As a developer you know your code best, so you should merge your code in.
* Builds should happen immediately after code is checked in, to ensure the build doesn't break from the developer's changes.
* Automated tests should be ran immediately after code is checked in, to ensure the tests don't fail from the developer's changes.
* Automated UI tests should be ran immediately after code is checked in.

Pipelines:
* Break up processes into parts that can be completed independently
* No manual intervention should ever be required.

Old School Delivery Process:
* Write instructions for deployment and hand off to operations team
* Operations team stands up prod
* Operations team looks for defects in prod. If defects are found, the release goes back to the development team.
* Once the release has been validated by the operations team it is ready to go out to production.

Issues with "old school" way of doing delivery:
* Instructions may be unclear
* Instructions have variations per environment (dev, qa, stage, prod)
* Prone to error due to so many manual tasks
* Deployments are somewhat sophisticated, and may involve downtime.

Continuous Delivery:
* Software can be deployed to production at any time - NOTE: this is not saying software IS released at any time... it's saying it CAN be. The QE team still needs to confirm it is working in a test environment before it's released to production. Continuous Deployment is a software development practice where software is automatically released to production - this is very difficult to achieve and only IT departments that have achieved a very high level of maturity will be able to do this due to the high level of risk.
* Some large organizations will use phased rollout to implement Continuous Deployment - they will use a small market to "pilot" the release, and then will continue rolling out the release if it is successful.
* Facebook does 50 daily production releases on average!!! That's about 1 prod release every 30 minutes!
* There are no instructions for deploying an environment - that occurs via script based automation.
* Environment variable values should be set via the pipeline
