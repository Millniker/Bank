using CreditService.DAL.Enum;

namespace CreditService.DAL.Entities;


public class Money
{
    public decimal Amount { get; private set; }
    public CurrencyType Currency { get; private set; }
    
    private Money() { } 

    public Money(decimal amount, CurrencyType currency)
    {
        Amount = amount;
        Currency = currency;
    }
    
}