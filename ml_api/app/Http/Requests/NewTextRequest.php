<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Contracts\Validation\Validator;
use Illuminate\Validation\ValidationException;
class NewTextRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */

    public function rules(): array
    {
        return [
            'text' => 'required|string'
        ];
    }


    protected function failedValidation(Validator $validator)
    {
        $res = response()->json(['success' => false,
            'message' => 'Validation failed',
            'errors' => $validator->errors()],
            422, [], JSON_UNESCAPED_UNICODE);
        throw new ValidationException($validator, $res);
    }
}
