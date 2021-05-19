class Job {
  final String description, iconUrl, location, salary, title;
  final List<String> photos;

  Job(
      {this.photos,
      this.description,
      this.iconUrl,
      this.location,
      this.salary,
      this.title});
}
