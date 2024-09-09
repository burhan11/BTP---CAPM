module.exports = async (service) => {

    service.on('greetings', (req, res) => {
        return 'Hello! Good Morning ' + req.data.name;
    });

    service.on('multiply', (req, res) => {
        return (req.data.num1 * req.data.num2);
    });

}