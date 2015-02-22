var HRIndex = React.createClass({
  getInitialState: function() {
    return {
      hrs: this.props.hrs
    }
  },

//  updateMessages: function() {
//    var self = this;
//    $.get('/messages', {limit: 5}, function(messages) {
//      self.setState({messages: messages});
//    });
//  },
//
//  componentDidMount: function() {
//    var self = this;
//    setInterval(function() { self.updateMessages() }, 5000);
//  },
//
  render: function() {
    return (
      <div>
        <h1>React component</h1>

        <TaHrList hrs={this.state.hrs} />
      </div>
    );
  }
});
