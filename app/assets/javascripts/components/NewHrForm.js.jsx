var NewHrForm = React.createClass({
  getInitialState: function() {
    return {
      text: ""
    }
  },

  updateNewHrValue: function() {
    var input = this.refs.newHr.getDOMNode();
    this.setState({text: input.value});
  },

  addNewHr: function(e) {
    e.preventDefault();
    $.post('/help_requests', {help_request: {description: this.state.text, ta_user_id: this.props.ta}},
      this.props.onNewHr);
    this.setState({text: ''});
  },

  render: function() {
    return (
      <div>
        <form onSubmit={this.addNewHr}>
          <input type="text"
                 ref="newHr"
                 value={this.state.text}
                 onChange={this.updateNewHrValue} />
          <button>Submit Help Request</button>
        </form>
      </div>
    );
  }
});
