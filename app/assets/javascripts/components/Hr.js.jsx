var Hr = React.createClass({
  getInitialState: function() {
    return {
      rating: this.props.values.is_complete
    }
  },

  updateHrIsComplete: function(newRating) {
    /* Send off request to server to inform of state change */
    var oldIsComplete = this.state.is_complete;
    var thisHrComponent = this;
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
    this.setState({isComplete: true});
  },

  render: function() {
    return (
        <div className="ta-hr">
           <h4> {this.props.values.description }</h4>
           <h5> Asked by StudentId: { this.props.values.student_full_name} </h5>
           <button onClick={this.updateHrIsComplete}>
           Mark as Done
           </button>
        </div>
    )
  }
});
