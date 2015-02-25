var StudentTaHrList = React.createClass({
  propTypes: {
    ta: React.PropTypes.object,
    helpRequests: React.PropTypes.arrayOf(React.PropTypes.object)
  },
   
  render: function () {
    var self = this;
    var firstName = this.props.ta.first_name;
    var lastName = this.props.ta.last_name;
    var title = "Help Requests for " + firstName + " " + lastName;
   
    var myHrs = [];
    this.props.helpRequests.forEach(function(x) {
      if (x.ta_user_id === self.props.ta.id) {
        myHrs.push(x);
      }
      return myHrs
    })
    var helpRequests = myHrs.map(function (hr) {
      var student = hr.student;
      var firstName = student.first_name;
      var lastName = student.last_name;
      var fullName = firstName + " " + lastName;

      return (
        <div>
          <h4>{hr.description}</h4>
          <h6>Asked by: {fullName}</h6>
        </div>
      );
    });

    return (
      <div>
        <h6> {helpRequests} </h6>
      </div>
    );
  }
});
