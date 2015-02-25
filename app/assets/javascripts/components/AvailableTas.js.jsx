var AvailableTas = React.createClass({
  getInitialState: function() {
    return {
      tas: this.props.tas
    }
  },

  render: function () {
    self = this
    var AvailableTas = this.props.tas.map(function (ta) {
      /* var student = hr.student; */
      var firstName = ta.first_name;
      var lastName = ta.last_name;
      var taTitle = "Help Requests for " + firstName + " " + lastName;
      /* var fullName = firstName + " " + lastName; */
      return (
        <div>
          <h4>{taTitle}</h4>
          <StudentTaHrList ta= { ta } helpRequests = {self.props.hrs}/>
        </div>
      );
    });
    return (
      <div>
        <h2>{AvailableTas}</h2>
      </div>
    );
  }
});




