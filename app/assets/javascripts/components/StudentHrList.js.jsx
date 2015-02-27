var StudentHrList = React.createClass({
  
  getInitialState: function() {
    return {
      tas: this.props.tas
    }
  },

  updateAnything: function() {
    var self = this;
    $.get('/help_requests', function(taObject) {
      self.setState({ tas: taObject});
    });
  },
  componentDidMount: function() {
    var self = this;
    self.updateAnything();
  },
  render: function() {
    var allItems = [];
    var self = this;
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    this.props.tas.forEach(function(taObject) {
      var taMD5Email = md5(taObject.email)
      var taGravatarLink = gravatarAddy + taMD5Email
      allItems.push(<img class="ta-avatar" src= { taGravatarLink } > </img>)
      allItems.push(<h1> Help Requests for  {taObject.full_name} </h1>)
      taObject.open_help_requests.forEach(function(studentHrs) {
        var studentMD5Email = md5(studentHrs.student_email)
        var studentGravatarLink = gravatarAddy + studentMD5Email
        allItems.push(<img class="student-avatar"  src= { studentGravatarLink } > </img>)
        allItems.push(<h5> {studentHrs.description} </h5>)
        allItems.push(<h6> -Asked by: {studentHrs.student_full_name} </h6>)
      })
      allItems.push(<NewHrForm ta={taObject.id} onNewHr={self.updateAnything} />)
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
