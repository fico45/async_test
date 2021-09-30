using System;

using WebSocketSharp;
using WebSocketSharp.Server;

namespace async_server_app
{

    public class Echo : WebSocketBehavior
    {
        protected override void OnMessage(MessageEventArgs e)
        {
            Console.WriteLine("Received message from client: " + e.Data);
            System.Threading.Thread.Sleep(3000);
            Send(e.Data);
        }
    }

    
    class Program
    {
        static void Main(string[] args)
        {
            // Create an instance of a WS client
            WebSocketServer wssv = new WebSocketServer("ws://localhost:8045");

            wssv.AddWebSocketService<Echo>("/Echo");

            wssv.Start();
            Console.WriteLine("Server started on ws://localhost:8045/Echo");

            Console.ReadKey();
            wssv.Stop();
        }
    }
}
