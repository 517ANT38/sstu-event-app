<?php

namespace App\Http\Requests;
use App\Rules\PhoneRule;
use Illuminate\Foundation\Http\FormRequest;

class RequestEventRequest extends FormRequest
{
    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'secondName' => 'required|string|max:100',
            'firstName' => 'required|string|max:100',
            'middleName' => 'string|max:255',
            'edu' => 'required|string|max:255',
            'phone' => ['required','string','max:10',new PhoneRule],
            'countChild' => 'required|integer',
            'fromClass' => 'required|integer|min:1|max:11',
            'toClass' => 'integer|min:1|max:11'
        ];
    }
}
