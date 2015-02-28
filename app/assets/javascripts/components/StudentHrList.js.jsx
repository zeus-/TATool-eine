var StudentHrList = React.createClass({
  
  getInitialState: function() {
    return {
      tas: this.props.tas
    }
  },

  componentDidMount: function() {
    var self = this;
  },
  render: function() {
    var allItems = [];
    var self = this;
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    this.props.tas.forEach(function(taObject) {
      var taMD5Email = md5(taObject.email)
      var taGravatarLink = gravatarAddy + taMD5Email
      var helpRequests = [];
      // Add all help requests to array
      taObject.open_help_requests.forEach(function(studentHrs) {
        var studentMD5Email = md5(studentHrs.student_email)
        var studentGravatarLink = gravatarAddy + studentMD5Email
        helpRequests.push(
          <div>
            <img className="student-avatar"  src={studentGravatarLink} />
            <h5> {studentHrs.description} </h5>
            <h6> -Asked by: {studentHrs.student_full_name} </h6>
          </div>
        )
      })
      
      allItems.push(
        <div className="col-sm-6">
          <img className="ta-avatar" src= { taGravatarLink } > </img>
          <h1> Help Requests for  {taObject.full_name} </h1>
          {helpRequests}
          <NewHrForm ta={taObject.id} onNewHr={self.props.forceUpdate} />
        </div>
      )
    });
    return (
      <div>
        <div className="student-hr">
          {allItems}
        </div>
      </div>
    );
  }
});
