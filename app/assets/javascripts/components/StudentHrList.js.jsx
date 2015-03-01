var StudentHrList = React.createClass({
  
  getInitialState: function() {
    return {
      tas: this.props.tas
    }
  },

  componentDidMount: function() {
    var self = this;
  },
  
  deleteHr: function() {
    var thisHrComponent = this
    this.props.tas.forEach(function(taObject) {
      taObject.open_help_requests.forEach(function(studentHrs) {
        $.ajax({
          url: '/students/' + studentHrs.student_id + '/help_requests/' + studentHrs.id,
          type: 'DELETE',
          error: function() {
          /* alert('Could not delete!') */
          }
        })
      })
    });
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
          <div className="student-hr">
            <div className="student-hr-content">
              <img src={studentGravatarLink} />
              <p> I need help with {studentHrs.description} </p>
              <h5> -Asked by: {studentHrs.student_full_name} </h5>
              <button onClick= {self.deleteHr} >
                <i className="fa fa-trash fa-lg"></i> 
              </button>
              <span className="edit">
                <i className="fa fa-pencil fa-lg"></i> 
              </span>

            </div>
          </div>
        )
      })
      
      allItems.push(
        <div className="col-sm-6 top">
          <div className= "student-header"> 
            <img src= { taGravatarLink } > </img>
            <h2> Help Requests for  {taObject.first_name} </h2>
            <NewHrForm ta={taObject.id} onNewHr={self.props.forceUpdate} />
          </div>
          {helpRequests}
        </div>
      )
    });
    return (
      <div>
        {allItems}
      </div>
    );
  }
});
