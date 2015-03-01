var CompletedHr = React.createClass({
  getInitialState: function() {
    return {
      isComplete: this.props.values.is_complete
    }
  },

  undoHrCompleteStatus: function(newRating) {
    /* Send off request to server to inform of state change */
    var oldIsComplete = this.props.values.is_complete;
    var thisHrComponent = this
    $.ajax({
      url: '/ta_help_requests/' + this.props.values.id + "/",
      type: 'PATCH',
      data: {help_request: {is_complete: false}},
      error: function() {
        // this is now window!
        alert('Could not save!')
        thisHrComponent.setState({isComplete: oldIsComplete});
      }
    });
  },

  render: function() {
    var gravatarAddy = "http://www.gravatar.com/avatar/"  
    var studentMD5Email = md5(this.props.values.student_email)
    var studentGravatarLink = gravatarAddy + studentMD5Email
    var completedList = [];

    return (
        <div className="ta-hr-completed-section">
          <img src= { studentGravatarLink } > </img>
          <h4> {this.props.values.description }</h4>
          <h5> Asked by Student: { this.props.values.student_full_name} </h5>
          <button onClick={this.undoHrCompleteStatus}>
          Undo
          </button>
        
        </div>
    )
  }
});
