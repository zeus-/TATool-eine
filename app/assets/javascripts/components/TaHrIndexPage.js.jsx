var TaHrIndexPage = React.createClass({
  getInitialState: function() {
    return {
      hrs: this.props.hrs
    }
  },

  updateHrs: function() {
    var self = this;
    $.get('/ta_help_requests', function(data) {
      self.setState({hrs: data.ta_help_requests});
    });
  },

  componentDidMount: function() {
    var self = this;
    setInterval(function() { self.updateHrs() }, 2000);
  },

  render: function() {
    return (
      <div>
        <h1>Your Help Requests</h1>

        <TaHrList hrs={this.state.hrs} />
      </div>
    );
  }
});
