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
    this.props.tas.forEach(function(taObject, i) {
      var taMD5Email = md5(taObject.email)
      var taGravatarLink = gravatarAddy + taMD5Email
      var helpRequests = [];
      
      // Add all help requests to array
      
      taObject.open_help_requests.forEach(function(studentHrs, number) {
        var studentMD5Email = md5(studentHrs.student_email)
        var studentGravatarLink = gravatarAddy + studentMD5Email
        var hrID = studentHrs.id
        helpRequests.push(
          <div key={number} className="student-hr">
            <div className="student-hr-content">
              <img src={studentGravatarLink} />
              <EditDescription hrs= {studentHrs}/>
              <DeleteStudentHr hrs= {studentHrs} thisid= {hrID} onDelete={self.props.forceUpdate}  />
            </div>
          </div>
        )
      })
      
      allItems.push(
        <div key= { i } className="top col-xs-12 col-sm-12 col-md-12 col-lg-6 entire-section">
          <div className="student-header"> 
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
