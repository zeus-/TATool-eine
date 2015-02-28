/* var tweenState = require('react-tween-state'); */

var Hr = React.createClass({
  /* mixins: [tweenState.Mixin], */
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
        <div className="ta-hr-section">
          <img src= { studentGravatarLink } > </img>
          <h4> {this.props.values.description }</h4>
          <h5> Asked by Student: { this.props.values.student_full_name} </h5>
          <button onClick={this.updateHrIsComplete}>
          Mark as Done
          </button>
        
        </div>
    )
  }
});
