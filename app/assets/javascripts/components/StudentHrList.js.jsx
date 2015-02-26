var StudentHrList = React.createClass({

  render: function() {
    var allItems = [];

    this.props.tas.forEach(function(taObject) {
      allItems.push(<h1> Help Requests for  {taObject.full_name} </h1>)
      taObject.open_help_requests.forEach(function(studentHrs) {
        allItems.push(<li> {studentHrs.description} </li>)
      })
    });

    return (
      <ul>
      {allItems}
      </ul>
    );
  }
});
