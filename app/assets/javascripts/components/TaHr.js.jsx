var Hr = React.createClass({
  getInitialState: function() {
    return {
      isComplete: this.props.values.is_complete
    }
  },

  updateHrIsComplete: function(newRating) {
    /* Send off request to server to inform of state change */
    var oldIsComplete = this.props.values.is_complete;
    var thisHrComponent = this
    $.ajax({
      url: '/ta_help_requests/' + this.props.values.id + "/",
      type: 'PATCH',
      data: {help_request: {is_complete: true}},
      error: function() {
        // this is now window!
        alert('Could not save!')
        thisHrComponent.setState({isComplete: oldIsComplete});
      }
    });

    /* Updates the state right away */
    
  },

  render: function() {
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    var studentMD5Email = md5(this.props.values.student_email)
    var studentGravatarLink = gravatarAddy + studentMD5Email
    var completedList = [];

    return (
        <div className="ta-hr-content">
          <img src= { studentGravatarLink } > </img>
          <p> Student needs help with {this.props.values.description }</p>
          <h5> Asked by Student: { this.props.values.student_full_name} </h5>
          <button className="checkbox" id="checkbox" onClick={this.updateHrIsComplete}>
          <i className="fa fa-check-square-o fa-3x"></i>
          <h6 className="done"> Mark as <br> </br>Complete </h6>
          </button>
        
        </div>
    )
  }
});
