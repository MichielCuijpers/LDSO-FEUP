# Table of contents

- [Feature branch workflow](#feature-branch-workflow)
  - [You are creating the branch and starting the feature implementation](#you-are-creating-the-branch-and-starting-the-feature-implementation)
  - [You are helping your colleague implementing a feature](#you-are-helping-your-colleague-implementing-a-feature)
- [Deploying to DigitalOcean](#deploying-to-digitalocean)


# Feature branch workflow

#### You are creating the branch and starting the feature implementation

- Create a branch for the US you will be implementing  
`git checkout -b US_2-01`

- Add new files/modifications/deletions to commit  
`git add .`

- Commit changes  
`git commit -m "Created DB table for Sorting Centers"`

- Push changes to feature branch  
`git push origin US_2-01`


#### You are helping your colleague implementing a feature

- Checkout the branch your colleague created  
`git checkout US_2-01`

- Pull the branch  
`git pull origin US_2-01`
