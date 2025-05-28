project1 = Project.create!(title: "Website Redesign", description: "Complete redesign of company website")
project2 = Project.create!(title: "Mobile App Development", description: "Build new mobile app for iOS and Android")

project1.issues.create!([
  { title: "Update homepage layout", status: "New", priority: 2 },
  { title: "Fix broken contact form", status: "In_Progress", priority: 1 },
  { title: "Add new product pages", status: "Closed", priority: 3 }
])

project2.issues.create!([
  { title: "Design app icon", status: "New", priority: 4 },
  { title: "Implement user authentication", status: "In_Progress", priority: 1 },
  { title: "Test on Android devices", status: "New", priority: 2 }
])
